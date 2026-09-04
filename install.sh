#!/bin/bash

# Apps
brew install --cask wezterm zen ayugram telegram raycast chatgpt karabiner-elements font-jetbrains-mono-nerd-font emacs figma obs steam bitwarden

# Tools
brew install fzf fd ripgrep opencode zsh-autosuggestions zsh-syntax-highlighting starship zoxide yazi git lazygit tmux fnm pnpm bat bat-extras fastfetch eza tpm delta tldr coreutils chafa ffmpeg-full resvg neovim

# Doom
if [ ! -d "$HOME/.config/emacs" ]; then
    git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"
    "$HOME/.config/emacs/bin/doom" install
fi
