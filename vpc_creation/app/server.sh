#!/usr/bin/env bash

cur_dir=$(dirname $0)
cd $cur_dir

echo "{\"hello\": \"world\", \"iam\": \"$(hostname -f)\" }" > hello
if python3 --version
then
  python3 -m http.server 8000
else
  python -m SimpleHTTPServer
fi
