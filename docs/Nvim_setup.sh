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
    CONDA_LINK="https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2019.10-Linux-x86_64.sh"
else
    CONDA_DIR=$HOME/tools/miniconda
    CONDA_NAME=Miniconda.sh
    CONDA_LINK="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py37_4.8.2-Linux-x86_64.sh"
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

# Install some Python packages used by Neovim plugins.
echo "Installing Python packages"
declare -a py_packages=("pynvim" 'python-lsp-server[all]' "black" "vim-vint" "pyls-isort" "pylsp-mypy")

if [[ "$SYSTEM_PYTHON" = true ]]; then
    echo "Using system Python to install $(PY_PACKAGES)"

    # If we use system Python, we need to install these Python packages under
    # user HOME, since we do not have permissions to install them under system
    # directories.
    for p in "${py_packages[@]}"; do
        pip install --user "$p"
    done
else
    echo "Using custom Python to install $(PY_PACKAGES)"
    for p in "${py_packages[@]}"; do
        "$CONDA_DIR/bin/pip" install "$p"
    done
fi

#######################################################################
#                Install node and vim-language-server                 #
#######################################################################
NODE_DIR=$HOME/tools/nodejs
NODE_SRC_NAME=$HOME/packages/nodejs.tar.gz
NODE_LINK="https://nodejs.org/dist/v14.15.4/node-v14.15.4-linux-x64.tar.xz"

mkdir -p $HOME/tools
# extract node to a custom directory, the directory should exist.
tar xvf node-v14.15.4-linux-x64.tar.xz --directory=$HOME/tools

if [[ -z "$(command -v node)" ]]; then
    echo "Install Nodejs"
    if [[ ! -f $NODE_SRC_NAME ]]; then
        echo "Downloading nodejs and renaming"
        wget $NODE_LINK -O "$NODE_SRC_NAME"
    fi

    if [[ ! -d "$NODE_DIR" ]]; then
        echo "Creating nodejs directory under tools directory"
        mkdir -p "$NODE_DIR"
        echo "Extracting to $HOME/tools/nodejs directory"
        tar zxvf "$NODE_SRC_NAME" -C "$NODE_DIR" --strip-components 1
    fi

    if [[ "$ADD_TO_SYSTEM_PATH" = true ]] && [[ "$USE_BASH_SHELL" = true ]]; then
        echo "export PATH=\"$NVIM_DIR/bin:\$PATH\"" >> "$HOME/.bash_profile"
    fi
else
    echo "Nodejs is already installed. Skip installing it."
fi

# Install vim-language-server
$NODE_DIR/bin/npm install -g vim-language-server

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
NVIM_SITE_DIR=$HOME/.local/share/nvim/site
NVIM_LINK="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
if [[ ! -f "$NVIM_DIR/bin/nvim" ]]; then
    echo "Installing Neovim"
    echo "Creating nvim directory under tools directory"

    if [[ ! -d "$NVIM_DIR" ]]; then
        mkdir -p "$NVIM_DIR"
    fi

    if [[ ! -f $NVIM_SRC_NAME ]]; then
        echo "Downloading Neovim"
        wget "$NVIM_LINK" -O "$NVIM_SRC_NAME"
    fi
    echo "Extracting neovim"
    tar zxvf "$NVIM_SRC_NAME" --strip-components 1 -C "$NVIM_DIR"

    if [[ "$ADD_TO_SYSTEM_PATH" = true ]] && [[ "$USE_BASH_SHELL" = true ]]; then
        echo "export PATH=\"$NVIM_DIR/bin:\$PATH\"" >> "$HOME/.bash_profile"
    fi
else
    echo "Neovim is already installed. Skip installing it."
fi

echo "Setting up config and installing plugins"
if [[ -d "$NVIM_CONFIG_DIR" ]]; then
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup"
fi

git clone --depth=1 https://github.com/jdhao/nvim-config.git "$NVIM_CONFIG_DIR"

echo "Installing packer.nvim"
git clone --depth=1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "Installing plugins"
"$NVIM_DIR/bin/nvim" +PackerInstall +qall

echo "Finished installing Neovim and its dependencies!"
