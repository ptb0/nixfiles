{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./zsh.nix
    ./gpg.nix
    ./neovim.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
