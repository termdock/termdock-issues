cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.19.0"
  sha256 arm:   "4bd16160c4a5aa8aad11a5122d9b4a5e771cef7b14a274f1f604b5cb4658f045",
         intel: "994e49fbf361a3d03bc2f402d556e023a369926fe6f8a5375e443bd0169e340f"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.19.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
