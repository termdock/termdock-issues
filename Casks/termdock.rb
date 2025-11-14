cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.3.4"
  sha256 arm:   "b4e4a6138ab4e326d4424623e25d8f662491b47f0a84a01f37f982165c54127a",
         intel: "6f339b0516957c2e170566e47589c2b47be78f285d1e12521ae75417910991b2"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.3.4/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
