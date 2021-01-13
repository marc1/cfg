#!/usr/bin/env bash

osascript<<EOF
    tell application "Safari"
	make new document
	activate
    end tell
EOF
