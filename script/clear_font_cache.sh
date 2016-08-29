#!/bin/sh

# NOTE: quit all Applications (except Terminal) before running this
sudo atsutil databases -removeUser && \
atsutil server -shutdown && \
atsutil server -ping && \
echo "Cleared font cache... Quit Terminal"


