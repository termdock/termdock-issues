cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.11.0"
  sha256 arm:   "1bb3795334cc4037fb5656a6803601e5e70ab2345d316acf7e58be68cc973d87",
         intel: "37b4b7cfa61ad8429c2e4f6eea4a52ea5212d0aaae47daa5aa6c6bf635d65d0a"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.11.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
