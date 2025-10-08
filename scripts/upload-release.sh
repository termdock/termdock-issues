#!/bin/bash

# Manual release upload script
# Usage: ./upload-release.sh <version> [path-to-assets]
# If no path provided, will use ../Termdock/dist

set -e

# Function to update Homebrew cask
update_homebrew_cask() {
    local version=$1
    local assets_path=$2
    local version_num=${version#v}
    
    # Calculate SHA256 for DMG files
    local intel_dmg="$assets_path/Termdock-${version_num}.dmg"
    local arm_dmg="$assets_path/Termdock-${version_num}-arm64.dmg"
    
    if [ ! -f "$intel_dmg" ] || [ ! -f "$arm_dmg" ]; then
        echo "⚠️  Warning: DMG files not found, skipping cask update"
        return
    fi
    
    local intel_sha=$(shasum -a 256 "$intel_dmg" | cut -d' ' -f1)
    local arm_sha=$(shasum -a 256 "$arm_dmg" | cut -d' ' -f1)
    
    # Update cask file
    local cask_file="Casks/termdock.rb"
    mkdir -p Casks
    
    cat > "$cask_file" << EOF
cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "$version_num"
  sha256 arm:   "$arm_sha",
         intel: "$intel_sha"

  url "https://github.com/termdock/Termdock-issues/releases/download/$version/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
EOF
    
    # Commit changes
    git add "$cask_file"
    git commit -m "Update Homebrew cask to $version" || echo "No changes to commit"
    git push || echo "Failed to push, please push manually"
    
    echo "✅ Homebrew cask updated to $version"
}

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
    # Extract version number without 'v' prefix
    VERSION_NUM=${VERSION#v}
    
    gh release create "$VERSION" \
        --title "TermDock $VERSION" \
        --draft \
        --notes "## Downloads (macOS Only)

### macOS
- **Termdock-${VERSION_NUM}.dmg** - Intel Mac installer
- **Termdock-${VERSION_NUM}-arm64.dmg** - Apple Silicon (M1/M2/M3) installer

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
echo "Uploading macOS release assets..."

# 1. Upload update metadata (critical for auto-update)
if [ -f "$ASSETS_PATH/latest-mac.yml" ]; then
    echo "📋 Uploading latest-mac.yml..."
    gh release upload "$VERSION" "$ASSETS_PATH/latest-mac.yml" --clobber
else
    echo "⚠️  Warning: latest-mac.yml not found (auto-update will not work)"
fi

# 2. Upload ZIP files (required for auto-update)
zip_count=0
for zip in "$ASSETS_PATH"/*.zip "$ASSETS_PATH"/*.zip.blockmap; do
    if [ -f "$zip" ]; then
        echo "📦 Uploading $(basename "$zip")..."
        gh release upload "$VERSION" "$zip" --clobber
        zip_count=$((zip_count + 1))
    fi
done

if [ $zip_count -eq 0 ]; then
    echo "⚠️  Warning: No ZIP files found (auto-update will not work)"
fi

# 3. Upload DMG files (for manual installation)
dmg_count=0
for dmg in "$ASSETS_PATH"/*.dmg "$ASSETS_PATH"/*.dmg.blockmap; do
    if [ -f "$dmg" ]; then
        echo "📦 Uploading $(basename "$dmg")..."
        gh release upload "$VERSION" "$dmg" --clobber
        dmg_count=$((dmg_count + 1))
    fi
done

if [ $dmg_count -eq 0 ]; then
    echo "❌ No DMG files found in $ASSETS_PATH"
    echo "Available files:"
    ls -la "$ASSETS_PATH"
    exit 1
fi

echo "✅ All release assets uploaded successfully!"
echo "   - latest-mac.yml: ✅"
echo "   - ZIP files: $zip_count"
echo "   - DMG files: $dmg_count"

# Update Homebrew cask
echo "🍺 Updating Homebrew cask..."
update_homebrew_cask "$VERSION" "$ASSETS_PATH"

echo "Done! Don't forget to publish the release when ready."
echo "Visit: https://github.com/termdock/Termdock-issues/releases"