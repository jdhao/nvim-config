#requires -Version 7.0
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param(
    # Where to put portable tools (Lua LS zip + extract)
    [string]$PortableToolsDir = (Join-Path $env:USERPROFILE 'portable_tools'),

    # Where your nvim config should live (stow-like: default = current directory)
    [string]$NvimTargetDir = (Resolve-Path -LiteralPath $PWD).Path,

    # Link location (AppData\Local\nvim)
    [string]$NvimLink = (Join-Path $env:LOCALAPPDATA 'nvim'),

    # Reinstall/replace where safe
    [switch]$Force,

    # Friendly name; behaves like -WhatIf
    [switch]$DryRun
)

if ($DryRun) {
    $WhatIfPreference = $true
}

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Info([string]$msg) { Write-Host "[INFO] $msg" }
function Write-Warn([string]$msg) { Write-Warning $msg }

function Invoke-IfApproved {
    param(
        [Parameter(Mandatory)][string]$Action,
        [Parameter(Mandatory)][string]$Target,
        [Parameter(Mandatory)][scriptblock]$Do
    )

    if ($PSCmdlet.ShouldProcess($Target, $Action)) {
        & $Do
    } else {
        Write-Info "[DryRun] $($Action): $Target"
    }
}

function Assert-Command([string]$Name) {
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command not found on PATH: $Name"
    }
}

function Ensure-Directory([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) {
        Invoke-IfApproved -Action 'Create directory' -Target $Path -Do {
            New-Item -ItemType Directory -Path $Path | Out-Null
        }
    }
}

function Ensure-Scoop {
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        Write-Info "Scoop already installed."
        return
    }

    Invoke-IfApproved -Action 'Install Scoop' -Target 'CurrentUser' -Do {
        Write-Info "Installing Scoop..."
        Invoke-WebRequest -UseBasicParsing "https://get.scoop.sh" | Invoke-Expression
    }

    # In DryRun, scoop won't actually exist; don't error.
    if (-not $DryRun -and -not (Get-Command scoop -ErrorAction SilentlyContinue)) {
        throw "Scoop install completed but 'scoop' command is still not available."
    }
}

function Ensure-ScoopBucket([string]$BucketName) {
    Assert-Command scoop
    $buckets = scoop bucket list 2>$null
    if ($buckets -and ($buckets -match "^\s*$BucketName\s*$")) {
        Write-Info "Scoop bucket already added: $BucketName"
        return
    }

    Invoke-IfApproved -Action 'Add scoop bucket' -Target $BucketName -Do {
        Write-Info "Adding scoop bucket: $BucketName"
        scoop bucket add $BucketName | Out-Null
    }
}

function Ensure-ScoopPackage([string]$PackageName) {
    Assert-Command scoop
    $installed = scoop list 2>$null | Select-String -Pattern "^\s*$PackageName\s" -Quiet
    if ($installed) {
        Write-Info "Scoop package already installed: $PackageName"
        return
    }

    Invoke-IfApproved -Action 'Install scoop package' -Target $PackageName -Do {
        Write-Info "Installing scoop package: $PackageName"
        scoop install $PackageName | Out-Null
    }
}

function Ensure-NpmGlobalPackage([string]$PackageName) {
    Assert-Command npm
    $list = npm ls -g --depth=0 --parseable 2>$null
    if ($list -and ($list | Select-String -Pattern "[\\/]$PackageName$" -Quiet)) {
        Write-Info "npm global already installed: $PackageName"
        return
    }

    Invoke-IfApproved -Action 'Install npm global' -Target $PackageName -Do {
        Write-Info "Installing npm global: $PackageName"
        npm install -g $PackageName | Out-Null
    }
}

function Ensure-PipPackage([string[]]$Packages) {
    Assert-Command pip
    foreach ($pkg in $Packages) {
        $exists = $true
        try { pip show $pkg 1>$null 2>$null } catch { $exists = $false }

        if ($exists) {
            Write-Info "pip package already present: $pkg"
        } else {
            Invoke-IfApproved -Action 'Install pip package' -Target $pkg -Do {
                Write-Info "Installing pip package: $pkg"
                pip install -U $pkg | Out-Null
            }
        }
    }
}

function Ensure-UserPathContains([string]$DirToAdd) {
    if (-not (Test-Path -LiteralPath $DirToAdd)) {
        throw "Cannot add to PATH; directory does not exist: $DirToAdd"
    }

    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $userPath = $userPath ?? ""

    $entries = $userPath -split ';' | Where-Object { $_ -and $_.Trim() -ne "" }
    $normalizedAdd = ([IO.Path]::GetFullPath($DirToAdd.TrimEnd('\'))).ToLowerInvariant()

    $already = $entries | Where-Object {
        try {
            ([IO.Path]::GetFullPath($_.TrimEnd('\'))).ToLowerInvariant() -eq $normalizedAdd
        } catch {
            $false
        }
    }

    if ($already) {
        Write-Info "User PATH already contains: $DirToAdd"
        return
    }

    $newPath = ($entries + $DirToAdd) -join ';'

    Invoke-IfApproved -Action 'Update User PATH' -Target $DirToAdd -Do {
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        Write-Info "Added to User PATH: $DirToAdd"
        Write-Warn "You may need to restart your terminal/session for PATH changes to take effect."
    }
}

function Ensure-Download([string]$Url, [string]$OutFile) {
    if ((-not $Force) -and (Test-Path -LiteralPath $OutFile)) {
        Write-Info "Download already exists, skipping: $OutFile"
        return
    }

    Invoke-IfApproved -Action 'Download' -Target $OutFile -Do {
        Write-Info "Downloading: $Url"
        Invoke-WebRequest -Uri $Url -OutFile $OutFile
    }
}

function Ensure-LuaLanguageServer {
    Assert-Command 7z

    $luaVersion = "3.6.11"
    $zipName = "lua-language-server-$luaVersion-win32-x64.zip"
    $url = "https://github.com/LuaLS/lua-language-server/releases/download/$luaVersion/$zipName"

    Ensure-Directory $PortableToolsDir

    $zipPath = Join-Path $PortableToolsDir "lua-language-server.zip"
    $extractDir = Join-Path $PortableToolsDir "lua-language-server"
    $binDir = Join-Path $extractDir "bin"
    $exePath = Join-Path $binDir "lua-language-server.exe"

    Ensure-Download -Url $url -OutFile $zipPath

    if ((-not $Force) -and (Test-Path -LiteralPath $exePath)) {
        Write-Info "Lua language server already extracted: $extractDir"
    } else {
        if (Test-Path -LiteralPath $extractDir) {
            Invoke-IfApproved -Action 'Remove existing extract dir' -Target $extractDir -Do {
                Write-Info "Removing existing extract dir: $extractDir"
                Remove-Item -LiteralPath $extractDir -Recurse -Force
            }
        }

        Invoke-IfApproved -Action 'Extract Lua language server' -Target $extractDir -Do {
            Write-Info "Extracting Lua language server to: $extractDir"
            7z x $zipPath ("-o$extractDir") -y | Out-Null
        }
    }

    # In DryRun, extraction won't happen; skip PATH add if bin doesn't exist.
    if (Test-Path -LiteralPath $binDir) {
        Ensure-UserPathContains $binDir
    } else {
        Write-Info "[DryRun] Would ensure User PATH contains: $binDir"
    }
}

function Ensure-Junction([string]$Link, [string]$Target) {
    $resolvedTarget = (Resolve-Path -LiteralPath $Target).Path

    if (Test-Path -LiteralPath $Link) {
        $item = Get-Item -LiteralPath $Link -Force

        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            $linkType = $item.LinkType
            $existingTargets = @($item.Target) | Where-Object { $_ }

            if ($linkType -eq 'Junction' -and $existingTargets.Count -gt 0) {
                $existing = (Resolve-Path -LiteralPath $existingTargets[0]).Path
                if ($existing -eq $resolvedTarget) {
                    Write-Info "Junction already correct: $Link -> $resolvedTarget"
                    return
                }

                if (-not $Force) {
                    throw "Junction exists but points elsewhere: $Link -> $existing (wanted $resolvedTarget). Use -Force to replace."
                }

                Invoke-IfApproved -Action 'Remove junction' -Target $Link -Do {
                    Write-Info "Replacing junction: $Link"
                    Remove-Item -LiteralPath $Link -Force
                }
            } else {
                if (-not $Force) {
                    throw "Path exists and is not a junction we can manage safely: $Link (LinkType=$linkType). Use -Force to replace."
                }

                Invoke-IfApproved -Action 'Remove existing path' -Target $Link -Do {
                    Write-Info "Removing existing path (Force): $Link"
                    Remove-Item -LiteralPath $Link -Recurse -Force
                }
            }
        } else {
            if (-not $Force) {
                throw "Path exists and is not a link: $Link. Use -Force to remove & replace."
            }

            Invoke-IfApproved -Action 'Remove existing non-link path' -Target $Link -Do {
                Write-Info "Removing existing non-link path (Force): $Link"
                Remove-Item -LiteralPath $Link -Recurse -Force
            }
        }
    }

    Invoke-IfApproved -Action 'Create junction' -Target "$Link -> $resolvedTarget" -Do {
        Write-Info "Creating junction: $Link -> $resolvedTarget"
        New-Item -ItemType Junction -Path $Link -Target $resolvedTarget | Out-Null
    }
}

try {
    Write-Info "=== NVIM Windows setup start ==="
    Write-Info "PortableToolsDir: $PortableToolsDir"
    Write-Info "NvimTargetDir:    $NvimTargetDir"
    Write-Info "NvimLink:         $NvimLink"
    Write-Info "Force:            $Force"
    Write-Info "DryRun:           $DryRun"

    # Execution policy: best-effort; avoid failing under org policy.
    Invoke-IfApproved -Action 'Set ExecutionPolicy' -Target 'CurrentUser RemoteSigned' -Do {
        try {
            Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        } catch {
            Write-Warn "Could not set ExecutionPolicy (likely policy-managed). Continuing. Details: $($_.Exception.Message)"
        }
    }

    Ensure-Scoop

    # In DryRun, Scoop may not be present yet; guard subsequent scoop actions.
    if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
        Write-Info "[DryRun] Scoop not present (expected). Would proceed with scoop installs after install."
    } else {
        # Core tools
        Ensure-ScoopPackage nodejs
        Ensure-ScoopPackage ripgrep

        Ensure-ScoopBucket extras
        Ensure-ScoopPackage universal-ctags

        Ensure-ScoopPackage miniconda3
        Ensure-ScoopPackage vcredist2022
        Ensure-ScoopPackage 7zip

        # Neovim
        Ensure-ScoopBucket versions
        Ensure-ScoopPackage neovim
        Ensure-ScoopPackage neovim-qt
    }

    # npm/pip require node/pip available; in DryRun before installs, they may be absent.
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        Ensure-NpmGlobalPackage vim-language-server
        Ensure-NpmGlobalPackage bash-language-server
    } else {
        Write-Info "[DryRun] Would install npm globals: vim-language-server, bash-language-server"
    }

    if (Get-Command pip -ErrorAction SilentlyContinue) {
        Ensure-PipPackage @(
            "pynvim",
            "python-lsp-server[all]",
            "pylsp-mypy",
            "python-lsp-isort"
        )
    } else {
        Write-Info "[DryRun] Would install pip packages: pynvim, python-lsp-server[all], pylsp-mypy, python-lsp-isort"
    }

    # Lua language server needs 7z; if not present in DryRun, just report intent.
    if (Get-Command 7z -ErrorAction SilentlyContinue) {
        Ensure-LuaLanguageServer
    } else {
        Write-Info "[DryRun] Would download/extract Lua language server and add its bin to PATH (requires 7z)."
    }

    # stow-like: link AppData\Local\nvim -> current working dir (or -NvimTargetDir)
    Ensure-Junction -Link $NvimLink -Target $NvimTargetDir

    Write-Info "=== NVIM Windows setup complete ==="
}
catch {
    Write-Error "Setup failed: $($_.Exception.Message)"
    throw
}
