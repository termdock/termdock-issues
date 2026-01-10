cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.4.1"
  sha256 arm:   "884ea43d25c732376505cb668fa57d4adc3ca0176d6ecda0aab49d90bbc28565",
         intel: "19b392d8cf228a9dcab86b48e4bd792f85686a5c572234d0f3b172a9cd143fbd"

  url "https://github.com/termdock/Termdock-issues/releases/download/1.4.1/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
