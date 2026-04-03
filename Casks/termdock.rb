cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.6.0"
  sha256 arm:   "42832d03b9dc286a0abc9f8a8e6364f2e2c9241b8e7f5c2b1aa89ff04de4c237",
         intel: "3f67f6f4a220fe0667fd5491b471d558ab6794f6ecd60ec76cd4d2ff9205ed5e"

  url "https://github.com/termdock/Termdock-issues/releases/download/1.6.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
