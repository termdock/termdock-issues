cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.7.0"
  sha256 arm:   "57b29647a0013b5a82699d990f9c700243fb247309ec88a93ad38eb940d96ea8",
         intel: "d516d40f974ae8404e2074357c0f0beb3b8d58f5b7876c1623dca2d65b7f06e3"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.7.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
