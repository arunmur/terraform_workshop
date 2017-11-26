#!/usr/bin/env bash

set -x

sudo useradd -ms /bin/bash -d /app myapp
sudo mv /tmp/app/* /app/
sudo ln -s /app/myapp.service /etc/systemd/system/
sudo chmod a+rwx /app/*
sudo systemctl start myapp
