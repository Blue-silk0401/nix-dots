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
    cliphist
    yazi
    git
    ghostty
    kitty
    jp2a
    gimp
    mullvad-browser
    nvfNeovim
    foliate
    calibre
    persepolis

    yt-dlp
    ffmpeg

    # Tui's and Fun
    cowsay
    lolcat
    fortune
    btop
    tree
    pipes-rs
    cbonsai
    cmatrix
    cava
    cliamp
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

    libnotify

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
    imagemagick
    xwayland-satellite

    mpv
    imv
    playerctl

    librewolf

    zsh-syntax-highlighting
    zsh-autosuggestions

    xdg-user-dirs
  ];

    imports = [
    ./modules/zsh.nix
    ./modules/ghostty.nix
    ./modules/fastfetch.nix
    ./modules/niri.nix
  ];

  # Keep your other settings here.
    


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

