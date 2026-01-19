cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.4.4"
  sha256 arm:   "486e0ecf83d9eb1b87ca3eded2a2a01b1314b07567e5bf1fca46beda7cd524ad",
         intel: "34ec78809eee40cd9462e329e326b6f41e1e9af4a982d4a34aef60a06fd48559"

  url "https://github.com/termdock/Termdock-issues/releases/download/1.4.4/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
