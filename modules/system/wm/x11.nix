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
    };
}
