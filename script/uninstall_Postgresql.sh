#!/bin/sh

# TODO: dynamically change PostgreSQL version number
sudo /Library/PostgreSQL/9.5/uninstall-postgresql.app/Contents/MacOS/installbuilder.sh

# Run if installed with Postgres Installer
# open /Library/PostgreSQL/9.5/uninstall-postgresql.app

# Remove the PostgreSQL and data folders not handled by installbuilder.sh
sudo rm -rf /Library/PostgreSQL

sudo rm /etc/postgres-reg.ini

# *** NOTE: Remove the PostgreSQL user using System Preferences -> Users & Groups at this step!!! ***

sudo rm /etc/sysctl.conf
