cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.15.0"
  sha256 arm:   "522756a7f4c5568a3be9d01db06c805b63e60cf81ab882e7ebab7f63436e0fca",
         intel: "e04abdf196abab4ba11df1faef437ca7a606747dc4154c086dc854ac16d6d778"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.15.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
