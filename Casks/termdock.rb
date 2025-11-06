cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.3.1"
  sha256 arm:   "c61b581ab34312e54a31994a596763edfda1c5e3f2726f03f1502b60a6e0c037",
         intel: "800da4eef33abbebcb2be28f5f9a98e4fadf08cb4c8a94eaf125017d7f1c3953"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.3.1/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
