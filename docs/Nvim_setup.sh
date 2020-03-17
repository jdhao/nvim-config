#!/bin/bash
set -exu
set -o pipefail

# Whether to python has been installed
PYTHON_INSTALLED=true

# If Python has been installed, then we need to know whether Python is provided
# by the system, or you have already installed Python under your HOME.
SYSTEM_PYTHON=true

# If SYSTEM_PYTHON is false, we need to decide whether to install
# Anaconda (INSTALL_ANACONDA=true) or Miniconda (INSTALL_ANACONDA=false)
INSTALL_ANACONDA=false

# Whether to add the path of the installed executables to system PATH
ADD_TO_SYSTEM_PATH=true

if [[ ! -d "$HOME/packages/" ]]; then
    mkdir -p "$HOME/packages/"
fi

if [[ ! -d "$HOME/tools/" ]]; then
    mkdir -p "$HOME/tools/"
fi

#######################################################################
#                    Anaconda or miniconda install                    #
#######################################################################

if [[ ! "$PYTHON_INSTALLED" = true ]]; then
    echo "Installing Python in user HOME"

    SYSTEM_PYTHON=false

    if [[ "$INSTALL_ANACONDA" = true ]]; then
        CONDA_DIR=$HOME/tools/anaconda
        CONDA_NAME=Anaconda.sh
        CONDA_LINK="https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh"
    else
        CONDA_DIR=$HOME/tools/miniconda
        CONDA_NAME=Miniconda.sh
        CONDA_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    fi

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
    if [[ "$ADD_TO_SYSTEM_PATH" = true ]]; then
        echo "export PATH=\"$CONDA_DIR/bin:\$PATH\"" >> "$HOME/.bash_profile"
    fi
    source "$HOME/.bash_profile"
fi


# Install some Python packages
echo "Installing Python packages"
PY_PACKAGES="pynvim jedi pylint flake8 yapf"

if [[ "$SYSTEM_PYTHON" = true ]]; then
    echo "Using system Python"

    # If we use system Python, we need to install these Python packages under user HOME,
    # since we do not have permission to install them under system directories.
    pip install --user $PY_PACKAGES
else
    echo "Using custom Python"
    pip install $PY_PACKAGES
fi


#######################################################################
#                            Ripgrep part                             #
#######################################################################

if [[ ! "$(command -v rg)" ]]; then
    echo "Install ripgrep"
    RIPGREP_DIR=$HOME/tools/ripgrep
    RIPGREP_SRC_NAME=$HOME/packages/ripgrep.tar.gz
    RIPGREP_LINK="https://github.com/BurntSushi/ripgrep/releases/download/12.0.0/ripgrep-12.0.0-x86_64-unknown-linux-musl.tar.gz"

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


    if [[ "$ADD_TO_SYSTEM_PATH" = true ]]; then
        echo "export PATH=\"$RIPGREP_DIR:\$PATH\"" >> "$HOME/.bash_profile"
    fi
fi

#######################################################################
#                            Ctags install                            #
#######################################################################

echo "Install ctags"
CTAGS_SRC_DIR=$HOME/packages/ctags
CTAGS_DIR=$HOME/tools/ctags
CTAGS_LINK="https://github.com/universal-ctags/ctags.git"

if [[ ! -f "$CTAGS_DIR/bin/ctags" ]]; then
    if [[ ! -d $CTAGS_SRC_DIR ]]; then
        mkdir -p "$CTAGS_SRC_DIR"
    else
        # Prevent an incomplete download.
        rm -rf "$CTAGS_SRC_DIR/*"
    fi

    cd "$CTAGS_SRC_DIR" && git clone $CTAGS_LINK .
    ./autogen.sh && ./configure --prefix="$CTAGS_DIR"
    make -j && make install

    if [[ "$ADD_TO_SYSTEM_PATH" = true ]]; then
        echo "export PATH=\"$CTAGS_DIR/bin:\$PATH\"" >> "$HOME/.bash_profile"
    fi
fi

#######################################################################
#                                Nvim install                         #
#######################################################################

echo "Installing Neovim"
echo "Creating nvim directory under tools directory"
NVIM_DIR=$HOME/tools/nvim
NVIM_SRC_NAME=$HOME/packages/nvim-linux64.tar.gz
NVIM_CONFIG_DIR=$HOME/.config/nvim
NVIM_LINK="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"

if [[ ! -f "$NVIM_DIR/bin/nvim" ]]; then
    if [[ ! -d "$NVIM_DIR" ]]; then
        mkdir -p "$NVIM_DIR"
    fi

    if [[ ! -f $NVIM_SRC_NAME ]]; then
        echo "Downloading Neovim"
        wget "$NVIM_LINK" -O "$NVIM_SRC_NAME"
        echo "Extracting neovim"
        tar zxvf "$NVIM_SRC_NAME" --strip-components 1 -C "$NVIM_DIR"
    fi
fi

echo "Setting up config and installing plugins"
if [[ -d "$NVIM_CONFIG_DIR" ]]; then
    mv "$NVIM_CONFIG_DIR" $NVIM_CONFIG_DIR.backup
fi

git clone https://github.com/jdhao/nvim-config.git "$NVIM_CONFIG_DIR" \
	&& "$NVIM_DIR/bin/nvim" +PlugInstall +qall

if [[ "$ADD_TO_SYSTEM_PATH" = true ]]; then
    echo "export PATH=\"$NVIM_DIR/bin:\$PATH\"" >> "$HOME/.bash_profile"
fi
