{
  pkgs,
  lib,
  inputs,
  ...
}: {
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    brews = [
      "wireguard-tools"
      "nicotine-plus"
      "haskell-stack"
      "wallpaper"
    ];

    casks = [
      "graalvm-jdk"
      "eclipse-java"

      # browsing
      "zen"
      
      # system misc stuff
      "middleclick"
      "balenaetcher"
      "foobar2000"
      "supercollider"
      "libreoffice"
    ];
  };
}
