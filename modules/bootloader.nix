{pkgs, ...}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 64;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.tmp.cleanOnBoot = true;
  boot.loader.timeout = 3;
  boot.loader.systemd-boot.editor = false;
  boot.loader.systemd-boot.consoleMode = "auto";
}
