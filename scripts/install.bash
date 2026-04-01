#!/bin/bash

# install as per the official guidelines...
# https://caddyserver.com/docs/install#debian-ubuntu-raspbian

sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy

# Remove the repo - to use customized caddy
sudo rm /etc/apt/sources.list.d/caddy-stable.list

sudo dpkg-divert --divert /usr/bin/caddy.default --rename /usr/bin/caddy
sudo update-alternatives --install /usr/bin/caddy caddy /usr/bin/caddy.default 10
sudo systemctl restart caddy

# When your custom caddy is ready and is available at /usr/bin/caddy.custom
VERSION=$(/usr/bin/caddy.custom version | awk '{print $1}' | tr -d v)
PRIORITY=$(echo $VERSION | tr -d .)
sudo cp /usr/bin/caddy.custom /usr/bin/caddy.custom-$VERSION
sudo update-alternatives --install /usr/bin/caddy caddy /usr/bin/caddy.custom-$VERSION $PRIORITY
sudo systemctl restart caddy

# Packages
# caddy add-package github.com/caddyserver/transform-encoder # for logging
# caddy add-package github.com/caddy-dns/cloudflare
