#!/usr/bin/env bash
set -e

echo "🚀 Bootstrapping Dev Container..."

echo "📦 Installing goimports..."
go install golang.org/x/tools/cmd/goimports@latest

echo "🔐 Setting up GitHub SSH trust..."
mkdir -p ~/.ssh
ssh-keyscan github.com > ~/.ssh/known_hosts
chmod 700 ~/.ssh
chmod 600 ~/.ssh/known_hosts

echo "🔍 Running make verify..."
make verify

echo "🧪 Running make test..."
make test

echo "✅ Dev Container bootstrap complete."