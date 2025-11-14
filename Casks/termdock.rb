cask "termdock" do
  arch arm: "arm64", intel: "x64"
  
  version "1.3.3"
  sha256 arm:   "02003a906d4109c590a6eaf6523a1fdfc66e56049c28d58d9cfec4acf0fd6261",
         intel: "924d7173fefe0fd32f21a274014bd1458618ce1afca19c6219de89dd49ffd7ee"

  url "https://github.com/termdock/Termdock-issues/releases/download/v1.3.3/Termdock-#{version}#{arch == :intel ? "" : "-arm64"}.dmg"
  name "Termdock"
  desc "AI-Powered Terminal Integration Platform"
  homepage "https://github.com/termdock/Termdock-issues"

  app "Termdock.app"
end
