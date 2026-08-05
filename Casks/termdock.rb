cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.18.0"
  sha256 arm:   "f385d14baa92bd1b6ad74ef979360f7a2e03e8a03c07ef249bf4802253de68d6",
         intel: "55d846156ece9fbc80d1fad0806b1239d76a4971952323dec4671ac058b0fa4c"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.18.0/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
