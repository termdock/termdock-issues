cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.14.0"
  sha256 arm:   "0884309f608aaafb56d9935a66d32bb91fe95de51d8d480fbb70fb4d87a92aa0",
         intel: "219f6033f1e33effb314879a6386acfd6d091b3dd67a6a6d8f766ac908d1e590"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.14.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
