#!/bin/sh

mkdir ~/.fonts
curl -s -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip > /tmp/jetbrainsmono.zip
unzip -o /tmp/jetbrainsmono.zip -d ~/.fonts
rm /tmp/jetbrainsmono.zip
fc-cache -fv
