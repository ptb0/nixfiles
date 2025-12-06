{ config, lib, inputs, pkgs, nixpkgs-master, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/bootloader.nix
    ../../modules/console.nix
    ../../modules/nix.nix
    ../../modules/services.nix
    ../../modules/users.nix
    ../../modules/shell.nix
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
     displayManager.sddm.enable = true;
     desktopManager.plasma6.enable = true;
  };

  ### MISC
  hardware.bluetooth.enable = true;

  ### PACKAGE LIST
  environment.systemPackages = with pkgs; [
      # typesetting
      texliveMedium
      typst

      # music
      strawberry
      nicotine-plus

      # games
      # dolphin-emu
      # rpcs3
      openttd

      # security
      keepassxc
      gnupg1

      # system
      p7zip
      kdePackages.partitionmanager
      wget
      vim

      # development
      emacs-pgtk
      git
      sbcl
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
