# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
    imports =
        [ 
            ./hardware-configuration.nix
        ];

    # ensure flakes are enabled
    nix.package = pkgs.nixFlakes;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # unfree support
    nixpkgs.config.allowUnfree = true;

    # bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "zephyrus"; # Define your hostname.
    networking.networkmanager.enable = true;

    # timezone and locale
    time.timeZone = "America/Chicago";
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

    # configure keymap in X11 (MOVE TO HOME-MANAGER)
    services.xserver = {
        enable = true;
        layout = "us";
        xkbVariant = "";

        windowManager.i3 = {
            enable = true;
            extraPackages = with pkgs; [
                dunst
                i3status
                i3lock
                i3blocks
                polybar
                rofi
                xdg-user-dirs
            ];
        };
    };

    # define a user account. don't forget to set a password with ‘passwd’.
    users.users.holo = {
        isNormalUser = true;
        description = "holo";
        extraGroups = [ "audio" "networkmanager" "wheel" ];
        packages = [ ];
    };

    environment.systemPackages = with pkgs; [
        curl
	git
        home-manager
        vim
        wget
    ];

    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    system.stateVersion = "23.11"; # Did you read the comment?
}
