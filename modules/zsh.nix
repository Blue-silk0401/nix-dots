{
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
      ll = "ls -lah";
      ls = "eza --icons";
      cat = "bat";
      v = "nvim";
      c = "clear";
      ".." = "cd ..";
      "..." = "cd ../..";
    };

    initContent = ''
      fastfetch
    '';
  };
}
