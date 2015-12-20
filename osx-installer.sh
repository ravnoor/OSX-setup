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
      graphicsmagick
      imagemagick
      rename
      ffmpeg
      python
      #sshfs
      git
      #curl
      #detox
      #duplicity
      nmap
      #ghostscript
      openssl
      p7zip
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
      #adium
      alfred
      appcleaner
      atom
      bartender
      basictex
      #beamer
      bettertouchtool
      caffeine
      colorpicker
      cyberduck
      #chromium
      #citrix-receiver
      #crashplan
      dropbox
      #evernote
      ffmpegx
      firefox
      flash
      flux
      google-chrome
      handbrake
      #imagealpha
      #imageoptim
      iterm2
      java
      lastpass
      latexit
      #launchbar
      manuscripts
      microsoft-office
      mou
      #nvalt
      #paragon-ntfs
      #qlmarkdown
      pandoc
      papers
      qlcolorcode
      qlmarkdown
      quicklook-json
      #seil [keyboard hacks]
      skype
      slack
      subler
      sublime-text
      the-unarchiver
      tex-live-utility
      texmaker
      transmission
      tuxera-ntfs
      #utorrent
      vlc
      virtualbox
      #xquartz
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
git clone https://gist.github.com/e22d9840f9ea2fee4716.git
sh e22d9840f9ea2fee4716/osx-for-hackers.sh

# Revert disable spotlight in osx-for-hackers.sh
sudo chmod 755 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Install Oh-My-ZSH
curl -L http://install.ohmyz.sh | sh
