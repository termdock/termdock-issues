cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.16.0"
  sha256 arm:   "cc958ff67413e8021824a5b1ad48cad8392d1eb7fa2f12da3aa77f463f619a8d",
         intel: "aabefc90ff79a5e688fe9109944026046ea00f60772af2eec9eccccf49d24ad5"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.16.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
