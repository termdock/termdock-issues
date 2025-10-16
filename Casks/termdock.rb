cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.2.23"
  sha256 arm:   "ca14ef9212f26897b6fdab4441663f1062f892f61fe0851d1e1ecc46a6c617aa",
         intel: "c1c0bdbd3874b1b5c2fd0a211f0f2ca9e48c5f81bad9c9d8ccd3c7669c311ba8"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.2.23/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
