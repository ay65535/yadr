#!/bin/sh

if [ ! -d "$HOME/.yadr" ]; then
    echo "Installing YADR for the first time"
    #git clone --depth=1 https://github.com/skwp/dotfiles.git "$HOME/.yadr"

    git clone --depth=1 https://github.com/ay65535/yadr.git "$HOME/Dropbox/yadr" || echo "Error occured. exiting.." && read && exit 1
    cd "$HOME"
    ln -sv Dropbox/yadr .yadr || echo "Error occured. exiting.." && read && exit 1
    cd "$HOME/.yadr"
    [ "$1" = "ask" ] && export ASK="true"
    rake install
else
    echo "YADR is already installed"
fi
