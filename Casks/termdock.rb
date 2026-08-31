cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.20.0"
  sha256 arm:   "b9c772e23e8398401f987f065f1a0d7556454afaa42d8c74557717ec0aec3f36",
         intel: "9f92054ae6a438dc1a0cd17e7befb0c93f00967fd2388bc1f4740fbddaf7c851"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.20.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
