#!/usr/bin/env bash

WORKSPACE=$HOME/w
REPOS=$HOME/src
CFG=$HOME/cfg

printf "Creating directories...\n"
mkdir $WORKSPACE $REPOS
printf "Linking '$WORKSPACE' to '$REPOS/marc1'...\n"
ln -s $WORKSPACE $REPOS/marc1

git clone https://github.com/marc1/cfg.git $WORKSPACE/cfg
printf "Linking '$WORKSPACE/cfg' to '$CFG'...\n"
ln -s $WORKSPACE/cfg $CFG

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

printf "Setting preferences...\n"
/bin/bash "$CFG/scripts/bootstrap/prefs.sh"

printf "Running yabai setup...\n"
/bin/bash "$CFG/scripts/bootstrap/yabai.sh"

chmod +x $CFG/bin/ok
for s in $CFG/scripts/*.sh; do
	chmod +x $s
done
