#!/usr/bin/env bash
set -euo pipefail

print_header() {
  printf "\n========================================\n"
  printf "%s\n" "$1"
  printf "========================================\n\n"
}

start_servers() {
  print_header "Starting Bungee and Server"

  [ -f "bungee/bungee.jar" ] || { echo "Missing bungee/bungee.jar"; exit 1; }
  [ -f "server/server.jar" ] || { echo "Missing server/server.jar"; exit 1; }

  echo "Starting Bungee..."
  (cd bungee && java -jar bungee.jar) &
  bg_pid=$!

  trap 'echo "Stopping Bungee..."; kill "$bg_pid" 2>/dev/null || true' EXIT INT TERM

  echo "Starting server..."
  cd server
  java -jar server.jar
}

main() {
  start_servers
}

main "$@"