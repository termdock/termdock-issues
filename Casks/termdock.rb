cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.3.5"
  sha256 arm:   "b3156dd1a780a4a7384d844e17b0df85bf19e9b582e38849c39654a8f6214872",
         intel: "1a8386bf266d17b3436ea606a18244179a2f52c10f5eed2cf7c2d6b383a57ae4"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.3.5/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
