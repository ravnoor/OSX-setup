#!/bin/sh

# Install Homebrew 
if test ! $(which brew); then
  printf "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew
brew update

# Update Unix Tools
brew install coreutils
brew install findutils
brew install bash
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Add to PATH
printf "$PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH" >> ~/.bash_profile

# Install others binaries
binaries=(
      dnscrypt-proxy --with-plugins
      graphicsmagick
      # imagemagick
      rename
      ffmpeg
      mkvtoolnix
      mp4v2
      mplayer
      python
      # sshfs
      git
      curl
      # detox
      # duplicity
      nmap
      # ghostscript
      openssl
      p7zip
      qpdf # decrypt pdf files
      unrar
      wget
      zsh
)

printf "installing binaries..."
brew install ${binaries[@]}

# Clean
brew cleanup

# Install Cask
brew install caskroom/cask/brew-cask

# Install Applications
apps=(
      1clipboard
      #adium
      airflow
      alfred
      appcleaner
      atom
      bartender
      basictex # mactex for full TeX installation
      # beamer
      bettertouchtool
      caffeine
      colorpicker
      cyberduck
      # chromium
      # citrix-receiver
      # crashplan
      dropbox
      dropzone
      # evernote
      ffmpegx
      firefox
      flash
      flux
      google-chrome
      google-nik-collection
      handbrake
      brew cask install handbrakecli
      # imagealpha
      # imageoptim
      iterm2
      java
      lastpass
      latexit
      # launchbar
      manuscripts
      mendeley-desktop
      microsoft-office
      mou
      nimble # wolfram menu client
      # nvalt
      # paragon-ntfs
      # qlmarkdown
      pandoc
      papers
      # pritunl # openvpn client
      qlcolorcode
      qlmarkdown
      quicklook-json
      # seil # keyboard hacks
      skype
      slack
      soundcast
      #subler
      sublime-text
      sshfs
      the-unarchiver
      tex-live-utility
      texmaker
      transmission
      tuxera-ntfs
      #utorrent
      viscosity # openvpn client
      vlc
      webkit2png
      wkhtmltopdf
      # virtualbox
      xquartz
)

printf "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

brew cask alfred link

brew cask cleanup


# Install Fonts
brew tap caskroom/fonts

# Fonts
fonts=(
  font-m-plus
  font-clear-sans
  font-roboto
)

echo "installing fonts..."
brew cask install ${fonts[@]}


# Install Mackup
brew install mackup

# Mackup backup applications config
mackup backup

# Run osx-for-hackers.sh
DIR=$(pwd)
if [ -d ~/git ]
then
  cd ~/git
else
    mkdir ~/git && cd ~/git
fi
git clone https://gist.github.com/98e14262d8508e0f0a84.git
sh 98e14262d8508e0f0a84/osx-for-hackers.sh

# Revert disable spotlight in osx-for-hackers.sh
sudo chmod 755 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set plain text as the default format in TextEdit with a terminal command
defaults write com.apple.TextEdit RichText -int 0

# Install Oh-My-ZSH
curl -L http://install.ohmyz.sh | sh
