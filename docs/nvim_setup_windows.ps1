# Install scoop
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex

# Install node
scoop install nodejs

# Install ripgrep
scoop install ripgrep

# Install universal-ctags
scoop bucket add extras
scoop install universal-ctags

# Install vim-language-server
npm install -g vim-language-server

# Install miniconda3
scoop install miniconda3

# Install pynvim
pip install -U pynvim

# Install python-language-server
pip install 'python-lsp-server[all]' pylsp-mypy pyls-isort

# Install neovim nightly
scoop bucket add versions
scoop install neovim
