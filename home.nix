{ config, pkgs, nvfNeovim, ... }:
{
  home.username = "tuser";
  home.homeDirectory = "/home/tuser";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    wget
    fastfetch
    eza
    bat
    zoxide
    tmux
    cmatrix
    cbonsai
    pipes-rs
    wl-clipboard
    yazi
    git
    tealdeer
    ghostty
    jp2a
    gimp
    mullvad-browser
    cowsay
    lolcat
    fortune
    btop
    tree
    fzf
    nvfNeovim

    gcc
    unzip
    nodejs
    lua5_1
    tree-sitter

    wlogout
    hyprlock
    fuzzel
    waybar
    swayidle
    grim
    slurp
    awww
    mpvpaper
    swaybg
    xwayland-satellite

    librewolf

    zsh-syntax-highlighting
    zsh-autosuggestions

    xdg-user-dirs
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";

    plugins = [
      "git"
      "sudo"
      "docker"
    ];
    };
 
    shellAliases = {
      ls = "eza --icons";
      cat = "bat";
    };
  };
  programs.home-manager.enable = true;
}

