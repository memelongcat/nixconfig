#!/usr/bin/env bash
git pull
sudo cp configuration.nix /etc/nixos/configuration.nix
sudo nixos-rebuild switch
