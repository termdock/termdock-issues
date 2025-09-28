#!/bin/bash

# Manual release upload script
# Usage: ./upload-release.sh <version> [path-to-assets]
# If no path provided, will use ../Termdock/dist

set -e

VERSION=$1
ASSETS_PATH=${2:-"../Termdock/dist"}

if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version> [path-to-assets]"
    echo "Example: $0 v1.2.15"
    echo "Example: $0 v1.2.15 ~/Downloads/termdock-builds"
    echo "Default assets path: ../Termdock/dist"
    exit 1
fi

# Convert to absolute path
ASSETS_PATH=$(cd "$ASSETS_PATH" && pwd)

if [ ! -d "$ASSETS_PATH" ]; then
    echo "Error: Assets directory '$ASSETS_PATH' does not exist"
    exit 1
fi

echo "Using assets from: $ASSETS_PATH"

echo "Creating release $VERSION..."

# Check if release already exists
if gh release view "$VERSION" >/dev/null 2>&1; then
    echo "Release $VERSION already exists. Uploading assets..."
else
    echo "Creating new release $VERSION..."
    gh release create "$VERSION" \
        --title "TermDock $VERSION" \
        --draft \
        --notes "## Downloads (macOS Only)

### macOS
- **Termdock-x.x.x.dmg** - Intel Mac installer
- **Termdock-x.x.x-arm64.dmg** - Apple Silicon (M1/M2/M3) installer

### 💡 Other Platforms
Windows and Linux versions are planned for future releases. Stay tuned!

## What's New
Please check the [Issues](https://github.com/termdock/Termdock-issues/issues) page for resolved issues in this release.

## Installation Instructions
1. Download the appropriate DMG file for your Mac
2. Open the DMG and drag Termdock to Applications folder
3. First launch may require allowing the app in System Preferences > Security & Privacy

## Report Issues
Found a bug? Please report it in our [Issues](https://github.com/termdock/Termdock-issues/issues) section."
fi

# Upload assets
echo "Uploading macOS installers..."

# Count DMG files
dmg_count=0
for dmg in "$ASSETS_PATH"/*.dmg; do
    if [ -f "$dmg" ]; then
        dmg_count=$((dmg_count + 1))
    fi
done

if [ $dmg_count -eq 0 ]; then
    echo "❌ No DMG files found in $ASSETS_PATH"
    echo "Available files:"
    ls -la "$ASSETS_PATH"
    exit 1
fi

echo "Found $dmg_count DMG file(s) to upload:"

# Find and upload DMG files
for dmg in "$ASSETS_PATH"/*.dmg; do
    if [ -f "$dmg" ]; then
        echo "📦 Uploading $(basename "$dmg")..."
        gh release upload "$VERSION" "$dmg" --clobber
    fi
done

echo "✅ All macOS installers uploaded successfully!"

echo "Done! Don't forget to publish the release when ready."
echo "Visit: https://github.com/termdock/Termdock-issues/releases"