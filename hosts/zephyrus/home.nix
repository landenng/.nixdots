{ pkgs, userSettings, ... }:

{
    imports = [
        (./. + "../../../modules/user/wm"+("/"+userSettings.wm+"/"+userSettings.wm)+".nix")
    ];

    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = userSettings.username;
    home.homeDirectory = "/home/"+userSettings.username;

    programs.home-manager.enable = true;

    nixpkgs.config = { allowUnfree = true; };

    home.stateVersion = "23.11";

    home.packages = with pkgs; [
        alacritty
        cargo
        discord
        eza
        feh
        ffmpeg
        firefox
        gcc
        gh
        gnumake
        htop
        jq
        neofetch
        neovim
        nodejs
        onefetch
        tmux
        vscode
    ];

    home.file = { };

    home.sessionVariables = {
        BROWSER = userSettings.browser;
        EDITOR = userSettings.editor;
        TERM = userSettings.term;
    };
}
