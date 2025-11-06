cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.3.2"
  sha256 arm:   "9f4fefed745e9c847244de806f5fe1a1494e07e6d2d91d26509319c06feeccfe",
         intel: "774ef6ccae8ff2b8cb46337cc29aa9c4903eb79a2d11778ec39cf9db8940d639"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.3.2/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
