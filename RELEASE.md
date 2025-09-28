# TermDock Release Guide

This repository serves as the public distribution point for TermDock installers and issue tracking.

## Release Methods

### Method 1: Manual Release (Recommended)

1. **Prepare your assets** in a local directory:
   ```
   ~/termdock-builds/
   ├── TermDock-Setup.exe      # Windows installer
   ├── TermDock.dmg            # macOS installer
   ├── TermDock.AppImage       # Linux universal
   ├── TermDock.deb            # Debian/Ubuntu
   └── TermDock.rpm            # Fedora/RHEL
   ```

2. **Run the upload script**:
   ```bash
   ./scripts/upload-release.sh v1.0.0 ~/termdock-builds
   ```

3. **Publish the release** on GitHub web interface

### Method 2: GitHub Actions Workflow

1. Go to **Actions** tab in GitHub
2. Select **Manual Release with Assets**
3. Click **Run workflow**
4. Fill in version and changelog
5. Upload assets manually to the created draft release

## File Naming Conventions

- **Windows**: `TermDock-Setup.exe` or `TermDock-v1.0.0-Setup.exe`
- **macOS**: `TermDock.dmg` or `TermDock-v1.0.0.dmg`
- **Linux AppImage**: `TermDock.AppImage` or `TermDock-v1.0.0.AppImage`
- **Debian**: `TermDock.deb` or `termdock_1.0.0_amd64.deb`
- **RPM**: `TermDock.rpm` or `termdock-1.0.0.x86_64.rpm`

## Version Tagging

Use semantic versioning: `v1.0.0`, `v1.0.1`, `v2.0.0-beta.1`

## Integration with Private Repo

### Option A: Manual Sync
1. Build in private repo
2. Download artifacts
3. Upload to this public repo using scripts above

### Option B: Cross-repo Actions (Advanced)
```yaml
# In your private repo
- name: Trigger public release
  uses: peter-evans/repository-dispatch@v2
  with:
    token: ${{ secrets.PUBLIC_REPO_TOKEN }}
    repository: username/termdock-issues
    event-type: release
    client-payload: '{"version": "${{ github.ref_name }}"}'
```

## Release Checklist

- [ ] Build tested on all platforms
- [ ] Version numbers updated
- [ ] Changelog prepared
- [ ] Assets uploaded
- [ ] Release notes written
- [ ] Release published (not draft)
- [ ] Announcement posted (if needed)

## Automation Ideas

1. **Auto-generate changelog** from commit messages
2. **Checksum verification** for downloaded assets
3. **Auto-close issues** mentioned in release notes
4. **Notification webhooks** to Discord/Slack