cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.8.1"
  sha256 arm:   "598217fed856c21fd2bcbdaa84fd18ea4b4be2512fba5ffdbb76d2b3e1b38b83",
         intel: "e5cbe05a9c1736d1de835e7e1f07d995c8ba6b352362f88a965d8eb063ee9ff8"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.8.1/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
