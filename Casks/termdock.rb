cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.5.3"
  sha256 arm:   "327b8da3cdc74e6402f31c0cc585d34b0b270b947de643f2a5e3f969089ff3fe",
         intel: "c325ae955d0afb96eaa7e275428273bbc6a82f7cfa4cb7d1478c6d0774d8a75a"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.5.3/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
