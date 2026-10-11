cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.23.0"
  sha256 arm:   "6b2d6181660f6c2429532d3458b6d1f42d1af6a892b5ef0435603f1ee8e27520",
         intel: "ab85f8248a756ec1b55120a0b0ef4e4a1d9a5543fa38497002a42be1b3d4efb8"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.23.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
