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
    wl-clipboard
    yazi
    git
    tealdeer
    ghostty
    kitty
    jp2a
    gimp
    mullvad-browser
    nvfNeovim
    foliate
    calibre
    persepolis 

    # Tui's and Fun
    cowsay
    lolcat
    fortune
    btop
    tree
    pipes-rs
    cbonsai
    cmatrix
    fzf

    gcc
    unzip
    nodejs
    lua5_1
    tree-sitter
    python3
    uv
    libGL
    SDL2

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

    mpv
    imv

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

