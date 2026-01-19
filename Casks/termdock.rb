cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.4.5"
  sha256 arm:   "641cef201284053ee52ae4cdb5329c2c33d7e553f9b164bf85054421af2c303d",
         intel: "3fafd66fea75e1989e33bea267c84e88f03ff6a0ce1344bea7be5920fc728cdb"

  url "https://github.com/termdock/Termdock-issues/releases/download/1.4.5/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
