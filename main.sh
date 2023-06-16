#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream

git clone --recurse-submodules https://git.sr.ht/~emersion/wlr-randr
cd wlr-randr
cp -rvf ../debian ./


# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
