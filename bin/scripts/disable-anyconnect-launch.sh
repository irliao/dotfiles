#!/bin/sh

# TODO: fix issue where removing .plist below causes AnyConnect to be unable to open (uninstalling then reinstall AnyConnect fixes this, but not desired solution)

# remove launch daemon so AnyConnect will not automatically open when Mac starts
sudo launchctl unload -w /Library/LaunchDaemons/com.cisco.anyconnect.vpnagentd.plist &&
  sudo rm /Library/LaunchDaemons/com.cisco.anyconnect.vpnagentd.plist &&
  echo "removed Cisco AnyConnect launcher; please remove AnyConnect from Login Items under System Preferences -> Users & Groups"
