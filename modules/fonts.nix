{pkgs, ...}: {
  fonts = {
    fontconfig = {
      allowBitmaps = true;
      defaultFonts = {
        monospace = ["Go Mono"];
        sansSerif = ["Liberation Sans"];
        serif = ["Liberation Serif"];
        emoji = ["noto-fonts-color-emoji"];
      };
    };

    packages = with pkgs; [
      go-font
      liberation_ttf
      noto-fonts-color-emoji
    ];
  };
}
