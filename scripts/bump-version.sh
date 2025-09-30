#!/usr/bin/env bash
set -e

BUMP_TYPE="${1:-patch}"

LATEST_TAG=$(git tag --sort=-v:refname | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' | head -n 1)

LATEST_TAG="${LATEST_TAG:-v0.0.0}"
VERSION="${LATEST_TAG#v}"

IFS='.' read -r MAJOR MINOR PATCH <<EOF
$VERSION
EOF

case "$BUMP_TYPE" in
  major)
    ((MAJOR++))
    MINOR=0
    PATCH=0
    ;;
  minor)
    ((MINOR++))
    PATCH=0
    ;;
  patch)
    ((PATCH++))
    ;;
  *)
    echo "❌ Invalid bump type: $BUMP_TYPE"
    echo "Usage: $0 [major|minor|patch]"
    exit 1
    ;;
esac

NEW_TAG="v${MAJOR}.${MINOR}.${PATCH}"

echo "🔖 Bumping version: $LATEST_TAG → $NEW_TAG"

# Create and push tag
git tag "$NEW_TAG"
git push origin "$NEW_TAG"

echo "✅ Tag $NEW_TAG pushed to origin"