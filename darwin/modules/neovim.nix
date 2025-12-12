{ pkgs, inputs, system, ... }:
let
  neovim-nightly = inputs.neovim-nightly-overlay.packages.${system}.neovim;
in
{
  programs.neovim = {
    enable = true;
    package = neovim-nightly;
  };
}
