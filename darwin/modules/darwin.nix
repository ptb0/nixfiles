{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  nix.enable = false;
  security.pam.services.sudo_local.touchIdAuth = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # document formatting
    pandoc
    typst
    jdt-language-server
    djvulibre
    emacs-macport

    # programming 
    sbcl
    (aspellWithDicts (dicts: with dicts; [en en-computers de]))
    haskell.compiler.ghc98

    # general
    iterm2
    keepassxc
    thunderbird
    firefox

    # system fixes
    unnaturalscrollwheels
  ];



  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  system = {
    stateVersion = 6;
    primaryUser = "ptb";

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
      NSGlobalDomain.ApplePressAndHoldEnabled = false;
      NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
      NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
      NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
      NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
      NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;

      NSGlobalDomain.AppleShowAllFiles = true;
      NSGlobalDomain.AppleShowAllExtensions = true;
      finder.AppleShowAllExtensions = true;
      finder.AppleShowAllFiles = true;
      finder.ShowPathbar = true;
      trackpad.Clicking = true;
      # hot corner dock.wvous-tr-corner =
      dock.autohide = true;
      # animation speeds
      dock.autohide-time-modifier = 0.2;
      dock.autohide-delay = 0.2;
      dock.expose-animation-duration = 0.1;
      NSGlobalDomain.NSWindowResizeTime = 0.05;
      NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;
      dock.mineffect = "suck";
      dock.mru-spaces = false;
      dock.show-recents = false;
      dock.tilesize = 40;
      dock.orientation = "left";
      dock.persistent-apps = [
	"/Applications/Nix Apps/iTerm2.app"
	"/Applications/Nix Apps/Emacs.app"
	"/Applications/Nix Apps/Thunderbird.app"
	"/Applications/Nix Apps/Firefox.app"
	"/Applications/Nix Apps/KeePassXC.app"
	"/Applications/foobar2000.app"
	"/Applications/SuperCollider.app"
	"/System/Applications/System Settings.app"
      ];

      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 1;
      };
    };
  };


  time.timeZone = "Europe/Amsterdam";

  users.users.ptb = {
    name = "ptb";
    home = "/Users/ptb";
  };
}
