cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.5.1"
  sha256 arm:   "deb2b190b2c4349e22677a3bf55e4d399a2747a9f46121815649c9cba104c8bb",
         intel: "5a50c4fb15fe855b03f8d076b878b7b21e9b12e258add6cecc4db7c2e6f37fe2"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.5.1/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
