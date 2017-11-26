#!/usr/bin/env bash

cat '{"hello": "world"}' > hello
if python3 --version
then
  python3 -m http.server 8000
else
  python -m SimpleHTTPServer
fi
