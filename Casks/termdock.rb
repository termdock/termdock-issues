cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.2.24"
  sha256 arm:   "f409795d510824ad4739206c199498cbed93cf2f81c4c8cd1815c58e76abecd4",
         intel: "d9500dcca4638a6d369bc2c39b020c74c8ef8630f94a6227a273b4edfd274bbd"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.2.24/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
