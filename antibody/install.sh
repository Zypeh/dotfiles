#!/bin/env bash

if which brew >/dev/null 2>&1; then
  brew untap getantibody/homebrew-antibody || true
  brew tap getantibody/homebrew-antibody
  brew install antibody
else
  curl -s https://raw.githubusercontent.com/getantibody/installer/master/install | bash -s
fi

antibody bundle < "$HOME/.config/antibody/bundles.txt" > ~/.bundles.txt
antibody bundle sindresorhus/pure >> ~/.bundles.txt
antibody bundle < "$HOME/.config/antibody/bundles-lazy.txt" >> ~/.bundles.txt
