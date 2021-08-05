#!/bin/bash

getopt -q fvlnwWZzasd $@ > /dev/null 2>&1
if [ $? -ne 0 ]; then
  ricty_generator $@ 1>&2
  exit 0
fi

wget -nc https://github.com/google/fonts/raw/main/ofl/inconsolata/static/Inconsolata-Regular.ttf
wget -nc https://github.com/google/fonts/raw/main/ofl/inconsolata/static/Inconsolata-Bold.ttf

wget -nc https://osdn.net/projects/mix-mplus-ipa/downloads/72511/migu-1m-20200307.zip -O migu-1m.zip
unzip -u -j migu-1m.zip 1>&2

ricty_generator $@ 1>&2

echo 'Revise character spacing' 1>&2
for font in Ricty*.ttf; do
  ttx -t OS/2 $font 1>&2
  sed -i -e "s/xAvgCharWidth value=\".*\"/xAvgCharWidth value=\"500\"/" ${font%.ttf}.ttx 1>&2
  mv $font $font.bak
  ttx -m $font.bak ${font%.ttf}.ttx 1>&2
done

echo 'Compress font fils' 1>&2
find . -name "Ricty*.ttf" | xargs zip -
