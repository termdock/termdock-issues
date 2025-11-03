cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.3.0"
  sha256 arm:   "49eec71c0aafc0a26ab297c6c361544a2b515bec44674bbaa10344886ac025e1",
         intel: "c7bff7657ffb7009198d413ed0849022602ad032cd689e541da7c8f2526d343c"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.3.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
