#!/bin/bash
# Copyright (C) Dmytro Stechenko
# License: http://www.gnu.org/licenses/gpl.html

set -euxo pipefail

             CALL_DIR=$(pwd)
DOTFILES_INSTALL_SRCS=$(dirname  "$0")
DOTFILES_INSTALL_SRCS=$(realpath "$DOTFILES_INSTALL_SRCS")

DOTFILES_EMACS_SRCS="$DOTFILES_INSTALL_SRCS/emacs"
DOTFILES_KITTY_SRCS="$DOTFILES_INSTALL_SRCS/kitty"
 DOTFILES_BASH_SRCS="$DOTFILES_INSTALL_SRCS/bash"
  DOTFILES_GIT_SRCS="$DOTFILES_INSTALL_SRCS/git"
 DOTFILES_TMUX_SRCS="$DOTFILES_INSTALL_SRCS/tmux"
   DOTFILES_I3_SRCS="$DOTFILES_INSTALL_SRCS/i3"

cd "$DOTFILES_INSTALL_SRCS"
git pull origin master

# shellcheck source=/dev/null
source "$DOTFILES_EMACS_SRCS/install.sh"

# shellcheck source=/dev/null
source "$DOTFILES_KITTY_SRCS/install.sh"

# shellcheck source=/dev/null
source "$DOTFILES_BASH_SRCS/install.sh"

# shellcheck source=/dev/null
source "$DOTFILES_GIT_SRCS/install.sh"

# shellcheck source=/dev/null
source "$DOTFILES_TMUX_SRCS/install.sh"

# shellcheck source=/dev/null
source "$DOTFILES_I3_SRCS/install.sh"

cd "$CALL_DIR"
