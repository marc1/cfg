#!/usr/bin/env bash

WORKSPACE=$HOME/w
REPOS=$HOME/src
CFG=$HOME/cfg

mkdir $WORKSPACE $REPOS
ln -s $WORKSPACE $REPOS/marc1

git clone https://github.com/marc1/cfg.git $WORKSPACE/cfg
ln -s $WORKSPACE/cfg $CFG

$(sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume)
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
rm -r ./result

#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
