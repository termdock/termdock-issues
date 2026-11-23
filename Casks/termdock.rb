cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.27.0"
  sha256 arm:   "45167655080292481ceb7e59d02c80510c46f04e97ce40c97bff49e32b7cd5e8",
         intel: "5590e963027f7a9ed94ee4afa884655a658a17aac854d813e97c3ed0a5a2e6d7"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.27.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
