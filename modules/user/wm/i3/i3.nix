{ pkgs, ... }:

{
    home.packages = with pkgs; [
        autorandr
        dunst
        flameshot
        i3status
        i3lock
        i3blocks
        polybar
        rofi
    ];

    # home.file.".config/i3/config" = ./config;
}
