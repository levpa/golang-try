#!/usr/bin/env bash
set -e

HOOK_PATH=".git/hooks/pre-commit"

echo "🔧 Installing pre-commit hook..."

cat > "$HOOK_PATH" <<'EOF'
#!/usr/bin/env bash
set -e

echo "🔍 Running make verify..."
make verify

echo "🧪 Running make lint..."
make lint

echo "🧪 Running make test..."
make test

echo "🧱 Running make check-build..."
make check-build
EOF

chmod +x "$HOOK_PATH"

echo "✅ Pre-commit hook installed at $HOOK_PATH"
