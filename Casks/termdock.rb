cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.28.0"
  sha256 arm:   "cdd9bc8677a1c2cfca7787c6b25a4dae50c4b64938c6667e72a9cb8f91feccd1",
         intel: "9b00c4b5973810cd6564d989712e1a3028ce862925384a2ba9ed17c6d933c5f1"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.28.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
