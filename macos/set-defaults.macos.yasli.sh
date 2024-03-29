#!/usr/bin/env bash

# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

log_info "Setting macOS defaults..."

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Run the screensaver if we're in the bottom-left hot corner.
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Hide Safari's bookmark bar.
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# iTerm2
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.config/iterm2-external-settings"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# VsCodeVim
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider
defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false    # For VS Codium
defaults delete -g ApplePressAndHoldEnabled                                      # If necessary, reset global default

# Rectangle
defaults write com.knollsoft.Rectangle sizeOffset -float 75             # Modify offset 75px
defaults write com.knollsoft.Rectangle snapEdgeMarginTop -int 40        # Snap margins
defaults write com.knollsoft.Rectangle snapEdgeMarginBottom -int 40     # Snap margins
defaults write com.knollsoft.Rectangle snapEdgeMarginLeft -int 40       # Snap margins
defaults write com.knollsoft.Rectangle snapEdgeMarginRight -int 40      # Snap margins

# Disables period on double-space.
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable Ctrl-left/right in the mission control
# Trick to understand how this was done: https://apple.stackexchange.com/questions/344494/how-to-disable-default-mission-control-shortcuts-in-terminal/344504
# NOTE: disabled for now, we're
# defaults -currentHost write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 79 "
#   <dict>
#     <key>enabled</key><false/>
#     <key>value</key><dict>
#       <key>type</key><string>standard</string>
#       <key>parameters</key>
#       <array>
#         <integer>65535</integer>
#         <integer>123</integer>
#         <integer>8650752</integer>
#       </array>
#     </dict>
#   </dict>
# "
# defaults -currentHost write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 80 "
#   <dict>
#     <key>enabled</key><false/>
#     <key>value</key><dict>
#       <key>type</key><string>standard</string>
#       <key>parameters</key>
#       <array>
#         <integer>65535</integer>
#         <integer>123</integer>
#         <integer>8781824</integer>
#       </array>
#     </dict>
#   </dict>
# "
# defaults -currentHost write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 81 "
#   <dict>
#     <key>enabled</key><false/>
#     <key>value</key><dict>
#       <key>type</key><string>standard</string>
#       <key>parameters</key>
#       <array>
#         <integer>65535</integer>
#         <integer>124</integer>
#         <integer>8650752</integer>
#       </array>
#     </dict>
#   </dict>
# "
# defaults -currentHost write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 82 "
#   <dict>
#     <key>enabled</key><false/>
#     <key>value</key><dict>
#       <key>type</key><string>standard</string>
#       <key>parameters</key>
#       <array>
#         <integer>65535</integer>
#         <integer>124</integer>
#         <integer>8781824</integer>
#       </array>
#     </dict>
#   </dict>
# "

log_success "..Done setting macOS defaults."
