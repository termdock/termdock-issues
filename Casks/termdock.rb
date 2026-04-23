cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.8.0"
  sha256 arm:   "aca3be1f98fee4f4b2d8bda1e7dafe18a465f57686a5eff1435b0cb5f679ceff",
         intel: "36a1d022769ba22ecb3416231ab5ec68632d0f4dfbc568d7141676cb43b68390"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.8.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
