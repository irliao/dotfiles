#!/bin/sh

# NOTE: only run this when the dorfiles/ is a fresh copy

# clone all submodules to local
git submodule init

# fetch latest for all submodules in local
git submodule update

