cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.24.0"
  sha256 arm:   "e1e37bdc2e2aba574e287923658009943b4136cdf9906393891194a96ef32208",
         intel: "7f8d724f7fb1cd73fa3ac1c76662995cadfa84d507719dc76230245aa076efb2"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.24.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
