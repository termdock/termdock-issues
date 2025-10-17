cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.2.25"
  sha256 arm:   "d316d2421653ecbe1e7b323547511706dfd8a12fcdc99b522b9ba7ce4fa21a78",
         intel: "1151398cb66248ab74f1d33be95218f1240c8be9fa315007d9e5067aeea90ae8"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.2.25/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
