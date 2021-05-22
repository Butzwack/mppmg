#!/bin/bash
export THREAD_COUNT=$(grep -c ^processor /proc/cpuinfo)

cd ~/git
git clone https://github.com/godotengine/godot.git
cd godot
scons -j$THREAD_COUNT target=release_debug tools=yes use_lto=yes
strip bin/*
