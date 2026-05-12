cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.10.0"
  sha256 arm:   "f67876c5b4cdcd881baacf487ec4a5b91cf947089442e27a36a6a84bb33c8eb4",
         intel: "54aaca3056f11d2e1b66768c425e469e4f403c34055d9d83136c055d0c33f901"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.10.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
