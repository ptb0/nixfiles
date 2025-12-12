{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/bootloader.nix
    ../../modules/console.nix
    ../../modules/nix.nix
    ../../modules/services.nix
    ../../modules/users.nix
    ../../modules/shell.nix
    ../../modules/displaymanager.nix
  ];

  time.timeZone = "Europe/Amsterdam";

  ### KEYBOARD
  services.xserver.xkb.layout = "eu";
  services.xserver.xkb.options = "ctrl:nocaps";

  ### NETWORKING
  networking = {
    hostName = "datalove";
    networkmanager.enable = true;
    firewall = {
      enable = true;
    };
  };

  ### SERVICES/DISPLAYMANAGER
  services = {
    desktopManager.plasma6.enable = true;
  };

  ### MISC
  hardware.bluetooth.enable = true;

  ### PACKAGE LIST
  environment.systemPackages = with pkgs; [
    # typesetting
    texliveMedium
    typst
    pandoc

    # music
    strawberry
    nicotine-plus

    # security
    keepassxc
    gnupg1

    # system
    p7zip
    curl
    wget
    eza

    # development
    emacs-pgtk
    neovim
    git
    fossil
    sbcl
    guile
    sqlite

    # nix specific tools
    manix
    nixd
    alejandra
    comma
  ];

  ### NIX ENABLED PACKAGES
  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = false; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # dont change lol
  system.stateVersion = "24.11";
}
