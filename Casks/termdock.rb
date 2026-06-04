cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.12.0"
  sha256 arm:   "a35af65a2de5f01ec414b672b854604abae6d82d5500ce39c92a16bcc78c84ce",
         intel: "7ebd6b05bfdf45357081e5c8a2b2f59ee4510b902a5cfedb72bd2f2ef0a92753"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.12.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
