cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.5.2"
  sha256 arm:   "15b3566f7dc6109e0eefb8a610dfd31cd2967542fe855b0fb10b03785944c8d7",
         intel: "034d74b61b92ab5803031c490dcd7ec48d7846e5cd2ea1ffc6b5d4c3530460f6"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.5.2/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
