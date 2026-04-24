cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.8.0"
  sha256 arm:   "8d2700979a5d2cdf82aad75aae7f922b41076e1ae53e321db32ad5db6c69a7b1",
         intel: "169936f4c79769d151f0614f4ae81135f39f27dd6d9b4868844dfab0d22e9337"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.8.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
