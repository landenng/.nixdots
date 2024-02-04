{ config, pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "holo";
    home.homeDirectory = "/home/holo";

    programs.home-manager.enable = true;

    nixpkgs.config = { allowUnfree = true; };

    home.stateVersion = "23.11";

    home.packages = with pkgs; [
        alacritty
        cargo
        discord
        eza
        firefox
        flameshot
        gcc
        gh
        gnumake
        python3
        neofetch
        neovim
        nodejs
        tmux
    ];

    home.file = { };

    home.sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "firefox";
        SHELL = "bash";
    };
}
