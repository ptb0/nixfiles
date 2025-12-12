{pkgs, ...}: {
  services.desktopmanager.plasma6.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.isoimagewriter
    kdePackages.kdepartitionmanager
    kdePackages.kate
  ];
}
