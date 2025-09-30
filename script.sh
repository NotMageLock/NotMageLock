#!/usr/bin/env bash
set -euo pipefail

mkdir -p ~/steamcmd ~/gamefiles
cd ~/steamcmd

if [ ! -f steamcmd.sh ]; then
  curl -sSL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz
fi

./steamcmd.sh +@sSteamCmdForcePlatformType windows +login mageisaprefix +force_install_dir ../gamefiles +app_update 3405340 validate +quit

cd ~/gamefiles
zip -r ~/game.zip .

cd ~
python3 -m http.server 8000 >/dev/null 2>&1 &
echo $! > ~/game_http.pid
echo "Serving ~/game.zip on port 8000 (PID $(cat ~/game_http.pid))"
