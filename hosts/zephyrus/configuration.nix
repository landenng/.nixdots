# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, systemSettings, userSettings, ... }:

{
    imports = [ 
        ../../modules/system/hardware-configuration.nix
        (./. + "../../../modules/system/wm"+("/"+userSettings.wm)+".nix")
    ];

    # ensure flakes are enabled
    nix.package = pkgs.nixFlakes;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # unfree support
    nixpkgs.config.allowUnfree = true;

    # amd gpu
    boot.initrd.kernelModules = [ "amdgpu" ];

    # bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = systemSettings.hostname;
    networking.networkmanager.enable = true;

    # timezone and locale
    time.timeZone = systemSettings.timezone;
    i18n.defaultLocale = systemSettings.locale;
    i18n.extraLocaleSettings = {
        LC_ADDRESS = systemSettings.locale;
        LC_IDENTIFICATION = systemSettings.locale;
        LC_MEASUREMENT = systemSettings.locale;
        LC_MONETARY = systemSettings.locale;
        LC_NAME = systemSettings.locale;
        LC_NUMERIC = systemSettings.locale;
        LC_PAPER = systemSettings.locale;
        LC_TELEPHONE = systemSettings.locale;
        LC_TIME = systemSettings.locale;
    };

    # define a user account. don't forget to set a password with ‘passwd’.
    users.users.${userSettings.username} = {
        isNormalUser = true;
        description = userSettings.name;
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

    system.stateVersion = "23.11"; # Did you read the comment?
}
