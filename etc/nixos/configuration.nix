{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

    nixpkgs.config = {
      allowUnfree = true;
      chromium.enableWideVine = true;
    };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
#  nixpkgs.config.allowBroken = true;

  boot.supportedFilesystems = ["ntfs" "exfat"];

  boot.kernel.sysctl."vm.max_map_count" = 262144;

  security.pki.certificates = [];
  #security.pki.certificates = [ "/home/isaac/.skyux/certs/skyux-server.pem" ];
  virtualisation.virtualbox = {
    host = {
      enable = true;
      addNetworkInterface = true;
    };
  };

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
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    extraHosts =
      ''
        127.0.0.1 docker.localhost
        127.0.0.1 local.docker
        10.233.81.101 ip-10-233-81-101
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
  };

  fonts.fonts = with pkgs; [
    inconsolata
    fira-code
  ];

  # Select internationalisation properties.
  console.keyMap = "dvorak";
  i18n = {
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
    firefox
    chromium
    rxvt_unicode
    xclip
    openjdk11

    rustc
    cargo
    binutils
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

  # List services that you want to enable:
  services = {
    timesyncd.enable = true;
    blueman.enable = true;
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
    printing.drivers = [pkgs.gutenprint];
    #samba.enable = true;
    #samba.package = pkgs.sambaFull;

    # Enable the X11 windowing system.
    xserver = {
        enable = true;
        layout = "us";
        xkbOptions = "ctrl:nocaps";
        # use `intel` driver (`nouveau` and `nvidia` do not work)
        videoDrivers = ["nvidia"];
        displayManager.lightdm.enable = true;
        displayManager.defaultSession = "gnome";
        windowManager.i3.enable = true;
        desktopManager.gnome3.enable = true;

        # Enable touchpad support.
        libinput.enable = true;
      };
  };

  hardware = {
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraConfig = ''
        load-module module-switch-on-connect
      '';
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.isaac = {
    isNormalUser = true;
    home = "/home/isaac";
    description = "Isaac Aggrey";
    extraGroups = ["wheel" "bumblebee" "docker" "audio" "wireshark" "dialout"];
    createHome = true;
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
