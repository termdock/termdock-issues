cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.9.0"
  sha256 arm:   "703396f3fc752ec3308d72a66ca6ca2d980118370f156ca9f5bc41baf2f59675",
         intel: "5aa66121d7a683346a5132609235364522c029da00154a0f1c1e72898c448c93"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.9.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
