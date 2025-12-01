{ config, lib, inputs, pkgs, nixpkgs-master, ... }: {

  imports = [
    #./disk.nix
    ../../../modules/shared
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 64;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "oak";
    networkmanager.enable = true;
    firewall = {
      enable = true;
    };
  };

  time.timeZone = "Europe/Amsterdam";
  
  services.xserver.xkb.layout = "eu";
  services.xserver.xkb.options = "ctr:nocaps";

  users.users."lain" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    packages =
      with pkgs; [
        # internet
        firefox
        # documents
        emacs-gtk
        (texlive.combine {
          inherit (pkgs.texlive)
            scheme-small
            dvisvgm
            dvipng
            amsmath
            ;
        })
        # music
        strawberry
        nicotine-plus
        # games
        #runelite
        runescape
        #dolphin-emu
        #rpcs3

        (prismlauncher.override {
          jdks = [
            graalvmPackages.graalvm-ce
            jdk
            zulu8
            zulu17
          ];
        })
        # misc
        keepassxc
        p7zip
        sbcl
        #kdePackages.kdenlive
      ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];


  programs.zsh.enable = true;

  services.xserver.enable = false;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  hardware.bluetooth.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
  };

  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings = {
      server.secret_key = "test";
      server.port = 8080;
      server.bind_address = "0.0.0.0";
      search.formats = [
        "html"
        "json"
        "rss"
      ];
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = false; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  nixpkgs.config.allowUnfree = true;

  fonts.fontDir.enable = true;
  fonts.fontconfig.allowBitmaps = true;


  environment.systemPackages = with pkgs; [
    vim
    wget
    gnupg1
    git
    kdePackages.partitionmanager
  ];

  system.stateVersion = "24.11";

}
