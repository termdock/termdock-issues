cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.4.2"
  sha256 arm:   "e00bc6a7e626e0105a285cfa79f75a2a85cad66f13bbc55a0edb0cbda9bb5a76",
         intel: "dc7985af1ecacb54d1e968112ba1728b82118653a60f8549395732bcadd8bcb5"

  url "https://github.com/termdock/Termdock-issues/releases/download/1.4.2/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
