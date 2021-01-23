#!/bin/bash

wget -nc https://github.com/google/fonts/raw/master/ofl/inconsolata/static/Inconsolata-Regular.ttf
wget -nc https://github.com/google/fonts/raw/master/ofl/inconsolata/static/Inconsolata-Bold.ttf

wget -nc https://osdn.net/projects/mix-mplus-ipa/downloads/72511/migu-1m-20200307.zip -O migu-1m.zip
unzip -u -j migu-1m.zip 1>&2

ricty_generator $@ 1>&2

ls Ricty*.ttf > /dev/null 2>&1
if [ $? -ne 0 ]; then
  exit 0
fi

echo 'Compress font fils' 1>&2
find . -name "Ricty*.ttf" | xargs zip -
