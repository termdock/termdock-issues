cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.2.22"
  sha256 arm:   "89c5bb5a149ca9ed6765e6c7c4eb89c201c43ab699d62ebfa416d9ff03a7fd0d",
         intel: "31e2e117c126dca20d7444f93c6a775981bb0865a45ae8e0de28c058152834ff"

  url "https://github.com/termdock/termdock-issues/releases/download/v#{version}/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/termdock-issues"

  app "Termdock.app"
end
