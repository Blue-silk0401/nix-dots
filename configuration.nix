{ config, pkgs, qml-niri, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.graceful = true;

  boot.blacklistedKernelModules = [ "rtl8xxxu" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8188eus-aircrack ];
  boot.kernelModules = [ "8188eu" ];

  networking.hostName = "nixos"; # Define your hostname.
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;


  hardware.enableRedistributableFirmware = true;


  time.timeZone = "Asia/Qatar";


  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.tuser = {
    isNormalUser = true;
    description = "Black_silence";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };


  nixpkgs.config.allowUnfree = true;
   
  swapDevices = [
    { device = "/swapfile"; size = 8192; } # size in MB, should be >= RAM amount
  ];
  

  environment.systemPackages = with pkgs; [
  qml-niri.packages.x86_64-linux.quickshell
  ];

  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
  nerd-fonts.jetbrains-mono
  noto-fonts
  noto-fonts-color-emoji
  font-awesome
  ];
  

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
  modesetting.enable = true;
  powerManagement.enable = true;
  open = true;
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics.enable = true;

  environment.sessionVariables = {
  LIBVA_DRIVER_NAME = "nvidia";
  GBM_BACKEND = "nvidia-drm";
  __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };


  programs.niri.enable = true;


  services.greetd = {
    enable = true;
    settings = {
      default_session = {
	command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
	user = "greeter";
      };
    };
  };
  


  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };



  security.polkit.enable = true;


  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
