{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.sessionVariables = {
    EDITOR = "emacs";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";

    history.size = 1000000;
    history.saveNoDups = true;
    history.ignorePatterns = [ "ls *" "pkill *" ];
    history.share = true;

    shellAliases = {
      v = "nvim";
      cdb = "cd ..";
      cdh = "cd ~/";
      cls = "clear";
      update = "sudo darwin-rebuild switch";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "cabal" "stack" "mvn" "gradle" "safe-paste" "sudo" ];
      custom = "${config.home.homeDirectory}/.zsh-custom";
      theme = "neon";
    };
  };
}
