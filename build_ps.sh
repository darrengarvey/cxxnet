#! /bin/bash

if [ ! -d ps-lite ]; then
    git clone https://github.com/dmlc/ps-lite
    echo "Install third-party libraries for PS"
    ./ps-lite/make/install_deps.sh 1>install_ps.log
    echo "Compile PS"
    make -j 4 -C ps-lite
fi

if [ ! -d rabit ]; then
    git clone https://github.com/dmlc/rabit.git
fi

if [ ! -d mshadow ]; then
    git clone https://github.com/dmlc/mshadow.git
fi

if [ ! -d dmlc-core ]; then
    git clone https://github.com/dmlc/dmlc-core.git
fi

if [ ! -f config.mk ]; then
    echo "Use the default config.m"
    cp make/config.mk config.mk
fi

sed -i 's/USE_DIST_PS.*/USE_DIST_PS = 1/' config.mk
sed -i 's/PS_PATH.*/PS_PATH = .\/ps-lite/' config.mk

# Use as many CPUs as the host has to build, or default to
# 4 if we're not on a unix-y system.
num_cpus=$(grep -sc ^processor /proc/cpuinfo || echo 4)
make -j$num_cpus
