#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports
apt install pika-sources.deb --yes --option Acquire::Retries=5 --option Acquire::http::Timeout=100 --option Dpkg::Options::="--force-confnew"
# Clone Upstream

git clone --recurse-submodules https://git.sr.ht/~emersion/wlr-randr
cd wlr-randr
cp -rvf ../debian ./


# Get build deps
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
