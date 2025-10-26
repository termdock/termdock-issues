cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.2.27"
  sha256 arm:   "5f41b1d549cbdeeb76e86ff130778a117175c0c9d727e4a0d7f0b53e8a0836d6",
         intel: "8f8ff2c38a5f935df3c7845e19c749a95b3e9568f9d9a61a2edbb0fba318b199"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.2.27/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
