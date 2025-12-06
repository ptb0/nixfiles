{ config, pkgs, ... }: {
  users.defaultUserShell = pkgs.zsh;
  users.users."do1ptb" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
    ];
  };
}
