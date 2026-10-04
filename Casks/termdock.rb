cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.22.0"
  sha256 arm:   "7a3475e29219480450b6f3fcb1d99a5dc42bfbfb025b53ef853c2af6a55ae01b",
         intel: "6189d5989ff8a5233408c8f2b954a00a2a0d3b29244f14a5075f1e281da0243f"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.22.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
