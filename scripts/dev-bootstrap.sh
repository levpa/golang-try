#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Bootstrapping Dev Container..."

sudo apt-get update && sudo apt-get upgrade -y

# Set timezone to Europe/Kyiv
sudo ln -sf /usr/share/zoneinfo/Europe/Kyiv /etc/localtime
sudo dpkg-reconfigure -f noninteractive tzdata

if ! command -v go &> /dev/null; then
  echo "❌ Go not found. Please install Go in the container base image."
  exit 1
fi

echo "🔍 Running make verify..."
make verify

echo "🧪 Running make test..."
make test

echo "✅ Dev Container bootstrap complete."
