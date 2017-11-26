#!/usr/bin/env bash

ip=$1
curl "http://$ip:8000/hello"
