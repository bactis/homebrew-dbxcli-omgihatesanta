cask "dbxcli" do
  version "3.0.0"
  sha256 "1149a2aa6a89829c6d540d04cc1db8cf5bb27e3d8b0ec6b32d830a6818bd7573"

  url "https://github.com/dropbox/dbxcli/releases/download/#{version}/dbxcli-darwin-amd64"
  appcast "https://github.com/dropbox/dbxcli/"
  name "010 Editor"
  homepage "https://www.dropbox.com"

  app "dxcli"
end
