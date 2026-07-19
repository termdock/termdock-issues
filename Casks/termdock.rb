cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.17.0"
  sha256 arm:   "24770eef19ed3d1c81faa6877e949d65a1d9728d0cf5390d6ade875e796877de",
         intel: "275cd1406c669a37e9292151fd06e07ddf2c8dd9d07ffe7bb274e71f762e1e35"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.17.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
