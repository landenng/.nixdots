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
        firefox
        gcc
        gh
        gnumake
        python3
        neofetch
        neovim
        nodejs
        onefetch
        tmux
        tree
    ];

    home.file = { };

    home.sessionVariables = {
        BROWSER = userSettings.browser;
        EDITOR = userSettings.editor;
        TERM = userSettings.term;
    };
}
