{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.addNetworkInterface = true;

  # networking.hostName = "nixos"; # Define your hostname.

  # Enables wireless support via wpa_supplicant.
  #networking.wireless = {
  #  enable = true;
  #  # TODO: this doesn't work -- getting invalid passphrase length of 64
  #  # networks = {
  #  #   "The Tower" = {
  #  #     #psk = "Sunsh1n3"
  #  #     psk = "1b374392f79968ccb6fe1f51d527de09f2e874d3275dc98774e2857f53170e6f";
  #  #   };
  #  # };
  #};
  networking.networkmanager.enable = true;
  networking.extraHosts =
    ''
      127.0.0.1 docker.localhost
      127.0.0.1 local.docker
      #192.168.2.53 securelogin.arubanetworks.com
      #172.16.217.20 securelogin.arubanetworks.com
      #172.31.98.0 securelogin.arubanetworks.com
      #172.31.98.1 securelogin.arubanetworks.com
      #172.31.99.1 securelogin.arubanetworks.com
      #172.31.98.0 aruba.odyssys.net
      #172.31.98.1 aruba.odyssys.net
      #172.31.99.1 aruba.odyssys.net
    '';
    # for starkbucks issue... should just need 172.31.98.1
    # nameserver 172.31.98.0
    # nameserver 172.31.98.1
    #nameserver 172.31.99.1

  networking.firewall.enable = false;


  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git
    neovim
    tmux
    docker
    fasd
    openjdk
    firefox
    chromium
    rxvt_unicode
    inconsolata
    xclip

    rustc
    cargo
    binutils
    gcc
    gnumake
    openssl
    pkgconfig
  ];
  # idea-ultimate
  # direnv
  # zsh-completions
  # ripgrep
  # network-manager-applet
  # tig
  # dynamic-colors
  # keychain
  # lsof
  # tree
  # telnet
  # spotify
  # teamviewer
  # gcc
  # azure-cli
  # python
  # moreutils (ts - timestamp tool)
  # httpie
  # jq
  # arandr
  # acpi
  # ranger
  # poppler-utils (pdf2text)
  # shutter
  # zplug - zsh plugin manager
  # vim plug - vim plugin manager
  # teensy-loader-cli
  # thunar
  # thunar-volman
  # chromedriver
  # rustc
  # rustup
  # cargo
  # clang
  # tokei
  # cloudfoundry-cli

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.zsh.enable = true;
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";
#  services.xserver.videoDrivers = ["nvidia"];
  services.xserver.videoDrivers = ["nouveau" "intel"];
  hardware.bumblebee.enable = true;
  hardware.bumblebee.connectDisplay = true;

  hardware.pulseaudio.enable = true;

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.isaac = {
    isNormalUser = true;
    home = "/home/isaac";
    description = "Isaac Aggrey";
    extraGroups = ["wheel" "bumblebee" "docker" "audio"];
    createHome = true;
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.nixos.stateVersion = "18.09"; # Did you read the comment?

}
