cask "dbxcli" do
  version "3.0.0"
  sha256 "1149a2aa6a89829c6d540d04cc1db8cf5bb27e3d8b0ec6b32d830a6818bd7573"

  url "https://github.com/dropbox/dbxcli/releases/download/v#{version}/dbxcli-darwin-amd64"
  appcast "https://github.com/dropbox/dbxcli/"
  name "dbxcli"
  homepage "https://www.dropbox.com"

  # Note that app is the exact binary name downloaded in the URL
  # target: is used to rename
  #app "dbxcli-darwin-amd64", target: "dbxcli-test"
  
  # Note not using app since this is a binary application
  #binary "dbxcli-test"
  
  # Removed, the symlink to rename it to dbxcli-test is getting permission errors
  #binary "dbxcli-darwin-amd64", target: "dbxcli-test"

  binary "dbxcli-darwin-amd64"

  # the following are actions performed while in the download dir
  #  ~/Library/Caches/Homebrew/downloads
  #  Should remove quartentine bit
  preflight do
      system_command "xattr", 
                      args: ["-d", "#{staged_path}/dbxcli-darwin-amd64"]
  end

end
