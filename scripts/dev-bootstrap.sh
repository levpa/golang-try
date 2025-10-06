#!/usr/bin/env bash
set -e

echo "🚀 Bootstrapping Dev Container..."
sudo apt-get update && sudo apt-get upgrade -y

echo "🔍 Running make verify..."
make verify

echo "🧪 Running make test..."
make test

echo "✅ Dev Container bootstrap complete."
