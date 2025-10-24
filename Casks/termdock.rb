cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.2.26"
  sha256 arm:   "1f81a556fb306e5fa47b26cf70802a1710632ca4ed49b51c275ae42ad3fde310",
         intel: "d417566cd57560dc810e3a31a81d73a425984a6a80f136439fe4c8ffa3aa8eac"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.2.26/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
