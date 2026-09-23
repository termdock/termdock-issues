cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.21.0"
  sha256 arm:   "4287ea98e17856f94c4802868b81f03ef89d3226f60936b496129d1fd6a3bade",
         intel: "c66897654e43bd2c3f2841ea8035d9cc94589afb7f23af8e2b7c8e39ffcfc9b7"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.21.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
