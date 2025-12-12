{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    slurp
    wl-clipboard
    light
    wmenu
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
