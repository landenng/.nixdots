{ pkgs, ... }:

{
    imports = [ 
        ./x11.nix
        ./pipewire.nix
        ./dbus.nix
    ];

    services.xserver = {
        windowManager.i3 = {
            enable = true;
        };
    };
}
