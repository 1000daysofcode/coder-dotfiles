#!/bin/bash -e

DEBIAN_FRONTEND=noninteractive sudo apt update -y
sudo apt install software-properties-common -y
source /verbis/functions.sh

verbis_defaults_main
verbis_symlink_cache_dir git
sudo ln -ds /mnt/cache/bridgehead /etc
rm -rf /home/coder/.cargo/registry
verbis_defaults_rust

script_dir=$(dirname "$(readlink -f "$0")")
# Yanked from https://github.com/bstollnitz/dotfiles/blob/main/install.sh
create_symlinks() {
    # Get the directory in which this script lives.
    

    # Get a list of all files in this directory that start with a dot.
    files=$(find -maxdepth 1 -type f -name ".*")

    # Create a symbolic link to each file in the home directory.
    for file in $files; do
        name=$(basename $file)
        echo "Creating symlink to $name in home directory."
        rm -rf ~/$name
        ln -s $script_dir/$name ~/$name
    done
}

create_symlinks || true

sudo apt install zsh tmux clang python3-pip gh ripgrep -y
sudo chsh -s $(which zsh)
sudo usermod -s $(which zsh) coder
ln -s $script_dir/.zshrc ~/.zshrc

mkdir -p ~/.config/nvim
mkdir -p ~/.config/tmux
mkdir -p ~/.config/tmux/tpm
ln -s $script_dir/.tmux.conf ~/.config/tmux/.tmux.conf || true
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

source $HOME/.config/tmux/.tmux.conf

curl -L -o out.tgz https://github.com/cargo-bins/cargo-binstall/releases/latest/download/cargo-binstall-x86_64-unknown-linux-musl.tgz
tar -xf out.tgz
mv cargo-binstall $HOME/.cargo/bin
rm out.tgz
source $HOME/.cargo/env
cargo binstall ripgrep bat tre-command starship zellij -y
# Install mold
curl -L https://github.com/rui314/mold/releases/download/v2.4.0/mold-2.4.0-x86_64-linux.tar.gz | sudo tar -C /usr/local --strip-components=1 --no-overwrite-dir -xzf -
echo '[target.x86_64-unknown-linux-gnu]
linker = "clang"
rustflags = ["-C", "link-arg=-fuse-ld=/usr/local/bin/mold"]' | sudo tee -a ~/.cargo/config.toml

stow -t ~ gitconfig

verbis_install_vscode_extensions ms-azuretools.vscode-docker eamodio.gitlens serayuzgur.crates tamasfe.even-better-toml

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
curl -L https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz | sudo tar -C /usr/local --strip-components=1 --no-overwrite-dir -xzf -
git clone https://github.com/NvChad/starter ~/.config/nvim

curl -fLo "FiraCode Nerd Font Regular.ttf" \
      https://github.com/ryanoasis/nerd-fonts/blob/bbe37e7f400105011868cfee5046f2727d4a5556/patched-fonts/FiraCode/Regular/FiraCodeNerdFontMono-Regular.ttf

ln -s $script_dir/lspconfig.lua ~/.config/nvim/lua/configs/lspconfig.lua || true
ln -s $script_dir/init.lua ~/.config/nvim/lua/plugins/init.lua || true

source $HOME/.profile
nvm install --lts
