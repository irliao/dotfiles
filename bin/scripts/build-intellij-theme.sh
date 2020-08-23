#!/bin/sh

# TODO: complete and verify this script

mkdir colors
cp $1 colors # $1 should be path to .xml color scheme file
touch 'IntelliJ IDEA Global Settings'

jar cfM 'NewTheme.jar' 'IntelliJ IDEA Global Settings' colors

rm -r colors
rm 'IntelliJ IDEA Global Settings'
