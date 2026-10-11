{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initContent = ''
      fastfetch

      # Your custom Zsh commands go here.
      alias ll="ls -lah"
      alias rebuild="home-manager switch"
    '';
  };
}
