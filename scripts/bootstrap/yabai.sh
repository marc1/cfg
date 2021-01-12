#!/usr/bin/env bash
DIR=/private/etc/sudoers.d/

echo "$(whoami) ALL = (root) NOPASSWD: /usr/local/bin/yabai --load-sa" | sudo tee $DIR/yabai 

sudo yabai --install-sa
sudo yabai --load-sa

brew services --all restart
