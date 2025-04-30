#!/bin/bash
set -exu
set -o pipefail

# Whether python3 has been installed on the system
PYTHON_INSTALLED=true

# If Python has been installed, then we need to know whether Python is provided
# by the system, or you have already installed Python under your HOME.
SYSTEM_PYTHON=false

# If SYSTEM_PYTHON is false, we need to decide whether to install
# Anaconda (INSTALL_ANACONDA=true) or Miniconda (INSTALL_ANACONDA=false)
INSTALL_ANACONDA=false

# Whether to add the path of the installed executables to system PATH
ADD_TO_SYSTEM_PATH=true

# select which shell we are using
USE_ZSH_SHELL=true
USE_BASH_SHELL=false

if [[ ! -d "$HOME/packages/" ]]; then
    mkdir -p "$HOME/packages/"
fi

if [[ ! -d "$HOME/tools/" ]]; then
    mkdir -p "$HOME/tools/"
fi

#######################################################################
#                    Anaconda or miniconda install                    #
#######################################################################
if [[ "$INSTALL_ANACONDA" = true ]]; then
    CONDA_DIR=$HOME/tools/anaconda
    CONDA_NAME=Anaconda.sh
    CONDA_LINK="https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2021.11-Linux-x86_64.sh"
else
    CONDA_DIR=$HOME/tools/miniconda
    CONDA_NAME=Miniconda.sh
    CONDA_LINK="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh"
fi

if [[ ! "$PYTHON_INSTALLED" = true ]]; then
    echo "Installing Python in user HOME"

    SYSTEM_PYTHON=false

    echo "Downloading and installing conda"

    if [[ ! -f "$HOME/packages/$CONDA_NAME" ]]; then
        curl -Lo "$HOME/packages/$CONDA_NAME" $CONDA_LINK
    fi

    # Install conda silently
    if [[ -d $CONDA_DIR ]]; then
        rm -rf "$CONDA_DIR"
    fi
    bash "$HOME/packages/$CONDA_NAME" -b -p "$CONDA_DIR"

    # Setting up environment variables
    if [[ "$ADD_TO_SYSTEM_PATH" = true ]] && [[ "$USE_BASH_SHELL" = true ]]; then
        echo "export PATH=\"$CONDA_DIR/bin:\$PATH\"" >> "$HOME/.bash_profile"
    fi
else
    echo "Python is already installed. Skip installing it."
fi

# Install some Python packages used by Nvim plugins.
echo "Installing Python packages"
declare -a PY_PACKAGES=("pynvim" 'python-lsp-server[all]' "vim-vint" "python-lsp-isort" "pylsp-mypy" "python-lsp-black")

if [[ "$SYSTEM_PYTHON" = true ]]; then
    echo "Using system Python to install $(PY_PACKAGES)"

    # If we use system Python, we need to install these Python packages under
    # user HOME, since we do not have permissions to install them under system
    # directories.
    for p in "${PY_PACKAGES[@]}"; do
        pip install --user "$p"
    done
else
    echo "Using custom Python to install $(PY_PACKAGES)"
    for p in "${PY_PACKAGES[@]}"; do
        "$CONDA_DIR/bin/pip" install "$p"
    done
fi

#######################################################################
#                Install node and js-based language server            #
#######################################################################
NODE_DIR=$HOME/tools/nodejs
NODE_SRC_NAME=$HOME/packages/nodejs.tar.gz
# when download speed is slow, we can also use its mirror site: https://mirrors.ustc.edu.cn/node/v15.0.0/
NODE_LINK="https://mirrors.ustc.edu.cn/node/v15.0.0/node-v15.0.0-linux-x64.tar.xz"
if [[ -z "$(command -v node)" ]]; then
    echo "Install Node.js"
    if [[ ! -f $NODE_SRC_NAME ]]; then
        echo "Downloading Node.js and renaming"
        wget $NODE_LINK -O "$NODE_SRC_NAME"
    fi

    if [[ ! -d "$NODE_DIR" ]]; then
        echo "Creating Node.js directory under tools directory"
        mkdir -p "$NODE_DIR"
        echo "Extracting to $HOME/tools/nodejs directory"
        tar xvf "$NODE_SRC_NAME" -C "$NODE_DIR" --strip-components 1
    fi

    if [[ "$ADD_TO_SYSTEM_PATH" = true ]] && [[ "$USE_BASH_SHELL" = true ]]; then
        echo "export PATH=\"$NODE_DIR/bin:\$PATH\"" >> "$HOME/.bash_profile"
    fi
else
    echo "Node.js is already installed. Skip installing it."
    NODE_DIR="$(realpath $(dirname $(which node))/..)"
fi

# Install vim-language-server
"$NODE_DIR/bin/npm" install -g vim-language-server

# Install bash-language-server
"$NODE_DIR/bin/npm" install -g bash-language-server

#######################################################################
#                         lua-language-server                         #
#######################################################################
LUA_LS_DIR=$HOME/tools/lua-language-server
LUA_LS_SRC=$HOME/packages/lua-language-server.tar.gz
LUA_LS_LINK="https://github.com/LuaLS/lua-language-server/releases/download/3.6.11/lua-language-server-3.6.11-linux-x64.tar.gz"

if [[ -z "$(command -v lua-language-server)" ]] && [[ ! -f "$LUA_LS_DIR/bin/lua-language-server" ]]; then
    echo 'Install lua-language-server'
    if [[ ! -f $LUA_LS_SRC ]]; then
        echo "Downloading lua-language-server and renaming"
        wget $LUA_LS_LINK -O "$LUA_LS_SRC"
    fi

    if [[ ! -d "$LUA_LS_DIR" ]]; then
        echo "Creating lua-language-server directory under tools directory"
        mkdir -p "$LUA_LS_DIR"
        echo "Extracting to directory $LUA_LS_DIR"

        tar zxvf "$LUA_LS_SRC" -C "$LUA_LS_DIR"
    fi

    if [[ "$ADD_TO_SYSTEM_PATH" = true ]] && [[ "$USE_BASH_SHELL" = true ]]; then
        echo "export PATH=\"$LUA_LS_DIR/bin:\$PATH\"" >> "$HOME/.bash_profile"
    fi
else
    echo "lua-language-server is already installed. Skip installing it."
fi

#######################################################################
#                            Ripgrep part                             #
#######################################################################
RIPGREP_DIR=$HOME/tools/ripgrep
RIPGREP_SRC_NAME=$HOME/packages/ripgrep.tar.gz
RIPGREP_LINK="https://github.com/BurntSushi/ripgrep/releases/download/12.0.0/ripgrep-12.0.0-x86_64-unknown-linux-musl.tar.gz"
if [[ -z "$(command -v rg)" ]] && [[ ! -f "$RIPGREP_DIR/rg" ]]; then
    echo "Install ripgrep"
    if [[ ! -f $RIPGREP_SRC_NAME ]]; then
        echo "Downloading ripgrep and renaming"
        wget $RIPGREP_LINK -O "$RIPGREP_SRC_NAME"
    fi

    if [[ ! -d "$RIPGREP_DIR" ]]; then
        echo "Creating ripgrep directory under tools directory"
        mkdir -p "$RIPGREP_DIR"
        echo "Extracting to $HOME/tools/ripgrep directory"
        tar zxvf "$RIPGREP_SRC_NAME" -C "$RIPGREP_DIR" --strip-components 1
    fi

    if [[ "$ADD_TO_SYSTEM_PATH" = true ]] && [[ "$USE_BASH_SHELL" = true ]]; then
        echo "export PATH=\"$RIPGREP_DIR:\$PATH\"" >> "$HOME/.bash_profile"
    fi

    # set up manpath and zsh completion for ripgrep
    mkdir -p "$HOME/tools/ripgrep/doc/man/man1"
    mv "$HOME/tools/ripgrep/doc/rg.1" "$HOME/tools/ripgrep/doc/man/man1"

    if [[ "$USE_BASH_SHELL" = true ]]; then
        echo 'export MANPATH=$HOME/tools/ripgrep/doc/man:$MANPATH' >> "$HOME/.bash_profile"
    else
        echo 'export MANPATH=$HOME/tools/ripgrep/doc/man:$MANPATH' >> "$HOME/.zshrc"
        echo 'export FPATH=$HOME/tools/ripgrep/complete:$FPATH' >> "$HOME/.zshrc"
    fi
else
    echo "ripgrep is already installed. Skip installing it."
fi

#######################################################################
#                            Ctags install                            #
#######################################################################
CTAGS_SRC_DIR=$HOME/packages/ctags
CTAGS_DIR=$HOME/tools/ctags
CTAGS_LINK="https://github.com/universal-ctags/ctags.git"
if [[ ! -f "$CTAGS_DIR/bin/ctags" ]]; then
    echo "Install ctags"

    if [[ ! -d $CTAGS_SRC_DIR ]]; then
        mkdir -p "$CTAGS_SRC_DIR"
    else
        # Prevent an incomplete download.
        rm -rf "$CTAGS_SRC_DIR"
    fi

    git clone --depth=1 "$CTAGS_LINK" "$CTAGS_SRC_DIR" && cd "$CTAGS_SRC_DIR"
    ./autogen.sh && ./configure --prefix="$CTAGS_DIR"
    make -j && make install

    if [[ "$ADD_TO_SYSTEM_PATH" = true ]] && [[ "$USE_BASH_SHELL" = true ]]; then
        echo "export PATH=\"$CTAGS_DIR/bin:\$PATH\"" >> "$HOME/.bash_profile"
    fi
else
    echo "ctags is already installed. Skip installing it."
fi

#######################################################################
#                                Nvim install                         #
#######################################################################
NVIM_DIR=$HOME/tools/nvim
NVIM_SRC_NAME=$HOME/packages/nvim-linux64.tar.gz
NVIM_CONFIG_DIR=$HOME/.config/nvim
NVIM_LINK="https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
if [[ ! -f "$NVIM_DIR/bin/nvim" ]]; then
    echo "Installing Nvim"
    echo "Creating nvim directory under tools directory"

    if [[ ! -d "$NVIM_DIR" ]]; then
        mkdir -p "$NVIM_DIR"
    fi

    if [[ ! -f $NVIM_SRC_NAME ]]; then
        echo "Downloading Nvim"
        wget "$NVIM_LINK" -O "$NVIM_SRC_NAME"
    fi
    echo "Extracting neovim"
    tar zxvf "$NVIM_SRC_NAME" --strip-components 1 -C "$NVIM_DIR"

    if [[ "$ADD_TO_SYSTEM_PATH" = true ]] && [[ "$USE_BASH_SHELL" = true ]]; then
        echo "export PATH=\"$NVIM_DIR/bin:\$PATH\"" >> "$HOME/.bash_profile"
    fi
else
    echo "Nvim is already installed. Skip installing it."
fi

echo "Setting up config and installing plugins"
if [[ -d "$NVIM_CONFIG_DIR" ]]; then
    rm -rf "$NVIM_CONFIG_DIR.backup"
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup"
fi

git clone --depth=1 https://github.com/jdhao/nvim-config.git "$NVIM_CONFIG_DIR"

echo "Installing nvim plugins, please wait"
"$NVIM_DIR/bin/nvim" -c "autocmd User LazyInstall quitall"  -c "lua require('lazy').install()"

echo "Finished installing Nvim and its dependencies!"
