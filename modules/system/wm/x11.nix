{ pkgs, ... }:

{
    imports = [ 
        ./pipewire.nix
        ./fonts.nix
        ./dbus.nix
    ];

    services.xserver = {
        enable = true;
        xkb.layout = "us";
        xkb.variant = "";

        windowManager.i3 = {
            enable = true;
            extraPackages = with pkgs; [
                dunst
                i3status
                i3lock
                i3blocks
                polybar
                rofi
            ];
        };
    };
}
