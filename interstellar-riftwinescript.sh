#!/bin/bash

SCRIPT_NAME=$(echo \"$0\" | xargs readlink -f)
SCRIPTDIR=$(dirname "$SCRIPT_NAME")

exec 6>display.log
/usr/bin/Xvfb -displayfd 6 &
XVFB_PID=$!
while [[ ! -s display.log ]]; do
  sleep 1
done
read -r DPY_NUM < display.log
rm display.log

wget -q -N https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks

export WINEPREFIX="$SCRIPTDIR/interstellar-rift/.wine"
export WINEARCH=win64
export WINEDEBUG=-all
export WINEDLLOVERRIDES="mscoree=d;mshtml="
export DISPLAY=:0
./winetricks corefonts > winescript_log.txt 2>&1
./winetricks sound=disabled >> winescript_log.txt 2>&1
./winetricks -q vcrun2012 >> winescript_log.txt 2>&1
./winetricks -q dotnet472 >> winescript_log.txt 2>&1
rm -rf ~/.cache/winetricks ~/.cache/fontconfig

exec 6>&-
kill $XVFB_PID

exit 0
