{ hostname ? "default", ... }: {
    networking.hostName = hostname; 

    #services.nix-daemon.enable = true;
    #nix.package = pkgs.nix;

    environment.variables = {
        EDITOR = "nvim";
    };

    system = {
        defaults = {
            LaunchServices.LSQuarantine = false;
            NSGlobalDomain = {
                AppleFontSmoothing = 2;
                AppleKeyboardUIMode = 3;
                AppleMeasurementUnits = "Centimeters";
                AppleMetricUnits = 1;
                ApplePressAndHoldEnabled = false;
                AppleShowAllExtensions = false;
                AppleShowScrollBars = "Always";
                AppleTemperatureUnit = "Celsius";
                InitialKeyRepeat = 12;
                KeyRepeat = 2;
                NSAutomaticCapitalizationEnabled = false;
                NSAutomaticDashSubstitutionEnabled = false;
                NSAutomaticPeriodSubstitutionEnabled = false;
                NSAutomaticSpellingCorrectionEnabled = false;
                NSDisableAutomaticTermination = false;
                NSDocumentSaveNewDocumentsToCloud = false;
                NSNavPanelExpandedStateForSaveMode = true;
                NSNavPanelExpandedStateForSaveMode2 = true;
                NSScrollAnimationEnabled = false;
                NSTableViewDefaultSizeMode = 2;
                NSTextShowsControlCharacters = true;
                NSUseAnimatedFocusRing = false;
                NSWindowResizeTime = "0.001";
                PMPrintingExpandedStateForPrint = true;
                PMPrintingExpandedStateForPrint2 = true;
                _HIHideMenuBar = true;
                "com.apple.keyboard.fnState" = true;
                "com.apple.mouse.tapBehavior" = null;
                "com.apple.springing.delay" = "0.0";
                "com.apple.springing.enabled" = true;
                "com.apple.swipescrolldirection" = false;
                "com.apple.trackpad.enableSecondaryClick" = true;
                "com.apple.trackpad.scaling" = "-1";
            };
            SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

            dock = {
                autohide = true;
                autohide-delay = "0.0";
                autohide-time-modifier = "0.6";
                dashboard-in-overlay = true;
                expose-animation-duration = "0.0";
                expose-group-by-app = false;
                launchanim = false;
                mineffect = "suck";
                minimize-to-application = true;
                mru-spaces = false;
                orientation = "right";
                show-process-indicators = true;
                show-recents = false;
                showhidden = true;
                static-only = true;
                tilesize = 42;
            };

            finder = {
                AppleShowAllExtensions = false;
                FXEnableExtensionChangeWarning = false;
                QuitMenuItem = true;
                _FXShowPosixPathInTitle = true;
            };

            loginwindow = {
                GuestEnabled = false;
                SHOWFULLNAME = false;
            };

            spaces.spans-displays = false;
            
        };
        stateVersion = 4;
    };

    environment.extraInit = ''
		# Close any open System Preferences panes, to prevent them from overriding
		# settings we’re about to change
		osascript -e 'tell application "System Preferences" to quit'

		# Ask for the administrator password upfront
		sudo -v

		# Keep-alive: update existing `sudo` time stamp until has finished
		while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

		###############################################################################
		# Misc                                                                        #
		###############################################################################

		# Disable Resume system-wide
		defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

		# set highlight color to light gray
		defaults write NSGlobalDomain AppleHighlightColor -string "0.8 0.8 0.8"

		# set background to gray
		osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Solid Colors/Space Gray Pro.png"'

		# don't show language menu in the top right corner of the boot screen
		sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool false

		# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
		defaults write com.apple.screencapture type -string "png"

		# Disable shadow in screenshots
		defaults write com.apple.screencapture disable-shadow -bool true

		# Avoid creating .DS_Store files on network or USB volumes
		defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
		defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

		# Disable send and reply animations in Mail.app
		defaults write com.apple.mail DisableReplyAnimations -bool true
		defaults write com.apple.mail DisableSendAnimations -bool true

		# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
		defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

		# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
		defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

		# Display emails in threaded mode, sorted by date (oldest at the top)
		defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
		defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
		defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

		# Disable inline attachments (just show the icons)
		defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

		# Prevent Photos from opening automatically when devices are plugged in
		defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

		# Show the main window when launching Activity Monitor
		defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

		# Visualize CPU usage in the Activity Monitor Dock icon
		defaults write com.apple.ActivityMonitor IconType -int 5

		# Show all processes in Activity Monitor
		defaults write com.apple.ActivityMonitor ShowCategory -int 0

		# Sort Activity Monitor results by CPU usage
		defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
		defaults write com.apple.ActivityMonitor SortDirection -int 0

        # clear all apps in dock
        defaults write com.apple.dock persistent-apps -array

		###############################################################################
		# Safari & WebKit                                                             #
		###############################################################################

		# Privacy: don’t send search queries to Apple
		defaults write com.apple.Safari UniversalSearchEnabled -bool false
		defaults write com.apple.Safari SuppressSearchSuggestions -bool true

		# Press Tab to highlight each item on a web page
		defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

		# Show the full URL in the address bar (note: this still hides the scheme)
		defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

		# Set Safari’s home page to `about:blank` for faster loading
		defaults write com.apple.Safari HomePage -string "about:blank"

		# Prevent Safari from opening ‘safe’ files automatically after downloading
		defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

		# Allow hitting the Backspace key to go to the previous page in history
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

		# Hide Safari’s bookmarks bar by default
		defaults write com.apple.Safari ShowFavoritesBar -bool false

		# Hide Safari’s sidebar in Top Sites
		defaults write com.apple.Safari ShowSidebarInTopSites -bool false

		# Disable Safari’s thumbnail cache for History and Top Sites
		defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

		# Enable Safari’s debug menu
		defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

		# Make Safari’s search banners default to Contains instead of Starts With
		defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

		# Remove useless icons from Safari’s bookmarks bar
		defaults write com.apple.Safari ProxiesInBookmarksBar "()"

		# Enable the Develop menu and the Web Inspector in Safari
		defaults write com.apple.Safari IncludeDevelopMenu -bool true
		defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

		# Add a context menu item for showing the Web Inspector in web views
		defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

		# Disable continuous spellchecking
		defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool false
		# Disable auto-correct
		defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

		# Disable AutoFill
		defaults write com.apple.Safari AutoFillFromAddressBook -bool false
		defaults write com.apple.Safari AutoFillPasswords -bool false
		defaults write com.apple.Safari AutoFillCreditCardData -bool false
		defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

		# Warn about fraudulent websites
		defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

		# Disable plug-ins
		defaults write com.apple.Safari WebKitPluginsEnabled -bool false
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

		# Disable Java
		defaults write com.apple.Safari WebKitJavaEnabled -bool false
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

		# Block pop-up windows
		defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

		# Disable auto-playing video
		defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
		defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
		defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

		# Enable “Do Not Track”
		defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

		# Update extensions automatically
		defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

		# Set up toolbar to hide extensions
		defaults write com.apple.Safari OrderedToolbarItemIdentifiers \
		    "(BackForwardToolbarIdentifier, InputFieldsToolbarIdentifier)" 

		###############################################################################
		# Mail                                                                        #
		###############################################################################

		# Disable send and reply animations in Mail.app
		defaults write com.apple.mail DisableReplyAnimations -bool true
		defaults write com.apple.mail DisableSendAnimations -bool true

		# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
		defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

		# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
		defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

		# Display emails in threaded mode, sorted by date (oldest at the top)
		defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
		defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
		defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

		# Disable inline attachments (just show the icons)
		defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

		# Disable automatic spell checking
		defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"

		###############################################################################
		# Spotlight                                                                   #
		###############################################################################

		# Change indexing order and disable some search results
		defaults write com.apple.spotlight orderedItems -array \
			'{"enabled" = 1;"name" = "APPLICATIONS";}' \
			'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
			'{"enabled" = 1;"name" = "DIRECTORIES";}' \
			'{"enabled" = 0;"name" = "PDF";}' \
			'{"enabled" = 0;"name" = "FONTS";}' \
			'{"enabled" = 0;"name" = "DOCUMENTS";}' \
			'{"enabled" = 0;"name" = "MESSAGES";}' \
			'{"enabled" = 0;"name" = "CONTACT";}' \
			'{"enabled" = 0;"name" = "EVENT_TODO";}' \
			'{"enabled" = 0;"name" = "IMAGES";}' \
			'{"enabled" = 0;"name" = "BOOKMARKS";}' \
			'{"enabled" = 0;"name" = "MUSIC";}' \
			'{"enabled" = 0;"name" = "MOVIES";}' \
			'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
			'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
			'{"enabled" = 0;"name" = "SOURCE";}' \
			'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
			'{"enabled" = 0;"name" = "MENU_OTHER";}' \
			'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
			'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
			'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
			'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
		# Load new settings before rebuilding the index
		killall mds > /dev/null 2>&1
		# Make sure indexing is enabled for the main volume
		sudo mdutil -i on / > /dev/null
		# Rebuild the index from scratch
		sudo mdutil -E / > /dev/null
    '';
}
