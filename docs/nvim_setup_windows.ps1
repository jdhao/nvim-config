#requires -Version 7.0
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param(
    # Where your nvim config should live (stow-like: default = current directory)
    [string]$NvimTargetDir = (Resolve-Path -LiteralPath $PWD).Path,

    # Link location (AppData\Local\nvim)
    [string]$NvimLink = (Join-Path $env:LOCALAPPDATA 'nvim'),

    # Replace an existing link/path if it points somewhere else
    [switch]$Force,

    # Dry run mode (no changes). Uses PowerShell's native ShouldProcess/WhatIf engine.
    [switch]$DryRun
)

if ($DryRun) { $WhatIfPreference = $true }

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Info([string]$msg) { Write-Host "[INFO] $msg`n" }
function Write-Warn([string]$msg) { Write-Warning "[WARNING] $msg`n" }

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
        scoop bucket add $BucketName | Out-Null
        Write-Info "Added scoop bucket: $BucketName"
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
        scoop install $PackageName | Out-Null
        Write-Info "Installed scoop package: $PackageName"
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
        npm install -g $PackageName | Out-Null
        Write-Info "Installed npm global: $PackageName"
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
                pip install -U $pkg | Out-Null
                Write-Info "Installed pip package: $pkg"
            }
        }
    }
}

function Ensure-Junction([string]$Link, [string]$Target) {
    $resolvedTarget = (Resolve-Path -LiteralPath $Target).Path

    if (Test-Path -LiteralPath $Link) {
        $item = Get-Item -LiteralPath $Link -Force

        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            $linkType = $item.LinkType
            $existingTargets = @(@($item.Target) | Where-Object { $_ }) # Outer @() forces result as array incase of 1 element so .Count is always valid

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
                    Remove-Item -LiteralPath $Link -Force
                    Write-Info "Removed existing junction: $Link"
                }
            } else {
                if (-not $Force) {
                    throw "Path exists and is not a junction we can manage safely: $Link (LinkType=$linkType). Use -Force to replace."
                }

                Invoke-IfApproved -Action 'Remove existing path' -Target $Link -Do {
                    Remove-Item -LiteralPath $Link -Recurse -Force
                    Write-Info "Removed existing path: $Link"
                }
            }
        } else {
            if (-not $Force) {
                throw "Path exists and is not a link: $Link. Use -Force to remove & replace."
            }

            Invoke-IfApproved -Action 'Remove existing non-link path' -Target $Link -Do {
                Remove-Item -LiteralPath $Link -Recurse -Force
                Write-Info "Removed existing path: $Link"
            }
        }
    }

    Invoke-IfApproved -Action 'Create junction' -Target "$Link -> $resolvedTarget" -Do {
        New-Item -ItemType Junction -Path $Link -Target $resolvedTarget | Out-Null
        Write-Info "Created junction: $Link -> $resolvedTarget"
    }
}

try {
    Write-Info "=== NVIM Windows setup start ==="
    Write-Info "NvimTargetDir: $NvimTargetDir"
    Write-Info "NvimLink:      $NvimLink"
    Write-Info "Force:         $Force"
    Write-Info "DryRun:        $DryRun"

    # Best-effort execution policy (won't hard fail in managed environments)
    Invoke-IfApproved -Action 'Set ExecutionPolicy' -Target 'CurrentUser RemoteSigned' -Do {
        try {
            Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        } catch {
            Write-Warn "Could not set ExecutionPolicy (likely policy-managed). Continuing. Details: $($_.Exception.Message)"
        }
    }

    Ensure-Scoop

    if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
        Write-Info "[DryRun] Scoop not present (expected). Would proceed with scoop installs after install."
    } else {
        # Buckets
        Ensure-ScoopBucket extras
        Ensure-ScoopBucket versions

        # Core tools
        Ensure-ScoopPackage nodejs
        Ensure-ScoopPackage ripgrep
        Ensure-ScoopPackage universal-ctags
        Ensure-ScoopPackage miniconda3
        Ensure-ScoopPackage vcredist2022
        Ensure-ScoopPackage 7zip

        # Neovim
        Ensure-ScoopPackage neovim
        Ensure-ScoopPackage neovim-qt

        # Lua language server (now in scoop)
        Ensure-ScoopPackage lua-language-server
    }

    # Language servers / python tooling
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        Ensure-NpmGlobalPackage vim-language-server
        Ensure-NpmGlobalPackage bash-language-server
    } else {
        Write-Info "[DryRun] Would install npm globals: vim-language-server, bash-language-server (requires npm on PATH)."
        if (-not $DryRun) {
            Write-Warn "npm not found. If you just installed nodejs via scoop, restart your terminal and re-run."
        }
    }

    if (Get-Command pip -ErrorAction SilentlyContinue) {
        Ensure-PipPackage @(
            "pynvim",
            "python-lsp-server[all]",
            "pylsp-mypy",
            "python-lsp-isort"
        )
    } else {
        Write-Info "[DryRun] Would install pip packages: pynvim, python-lsp-server[all], pylsp-mypy, python-lsp-isort (requires pip on PATH)."
        if (-not $DryRun) {
            Write-Warn "pip not found. If you're relying on miniconda3, ensure its shims are on PATH or open a new terminal."
        }
    }

    # stow-like: link AppData\Local\nvim -> current working dir (or -NvimTargetDir)
    Ensure-Junction -Link $NvimLink -Target $NvimTargetDir

    Write-Info "=== NVIM Windows setup complete ==="
}
catch {
    Write-Error "Setup failed: $($_.Exception.Message)"
    throw
}
