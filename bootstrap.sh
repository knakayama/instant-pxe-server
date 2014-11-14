#!/bin/bash -ex

if [ ! -f "/etc/sudoers.d/vagrant" ]; then
    echo "Defaults:vagrant    !requiretty" > "/etc/sudoers.d/vagrant"
fi

if date | grep -q 'UTC'; then
    ln -fs "/usr/share/zoneinfo/Asia/Tokyo" "/etc/localtime"
fi

if grep -qF 'us.archive.ubuntu.com' "/etc/apt/sources.list"; then
    sed -i 's@http://us\.archive\.ubuntu\.com\/ubuntu@http://jp\.archive\.ubuntu\.com/ubuntu@' "/etc/apt/sources.list"
fi

sudo apt-get update -y
sudo apt-get upgrade -y

