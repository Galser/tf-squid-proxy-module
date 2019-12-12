#!/usr/bin/env bash
# Provision script for Squid proxy instance
sudo apt update -q -y
if [ $? -ne 0 ]; then
  echo "First APT update failed, retrying"
  for i in 1 2 3
  do
    sudo apt update -q -y
    if [ $? -eq 0 ]; then
      break;
    fi # APT success
  done # APT repeats
  exit 1
fi
which squid || (
  sudo apt install -y curl wget squid
)