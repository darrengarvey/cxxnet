#! /bin/bash

if [ ! -d mshadow ]; then
    git clone https://github.com/dmlc/mshadow.git
fi

if [ ! -d rabit ]; then
    git clone https://github.com/dmlc/rabit.git
fi

if [ ! -d dmlc-core ]; then
    git clone https://github.com/dmlc/dmlc-core.git
fi


if [ ! -f config.mk ]; then
    echo "Use the default config.m"
    cp make/config.mk config.mk
fi

# Use as many CPUs as the host has to build, or default to
# 4 if we're not on a unix-y system.
num_cpus=$(grep -sc ^processor /proc/cpuinfo || echo 4)
make -j$num_cpus

