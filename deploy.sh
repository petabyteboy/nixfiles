#!/usr/bin/env bash

if [[ "$#" -ne "2" ]]
then
  echo "usage: $0 HostConfig RemoteHost"
  echo "HostsConfig (RemoteHost):"
  echo "  aleph (sivizius.eu) – Hetzner Cloud Server"
  echo "  bet   (localhost)   – T530 Laptop"
else
  HostConfig="#1"
  RemoteHost="#2"

  echo "Deploy $HostConfig on $RemoteHost…"
  nixos-rebuild dry-build --use-remote-sudo --build-host "localhost" --target-host "$RemoteHost" -I NIXOS_CONFIG="$HostConfig"
  echo "…done"
fi
