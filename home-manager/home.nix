{ pkgs, stateVersion, username, ... }:

{
  imports = [
    ./home/alacritty.nix
    ./home/bash.nix
    ./home/direnv.nix
    ./home/git.nix
    ./home/starship.nix
    ./home/zellij.nix
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [ "window-list@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" "blur-my-shell@aunetx" "forge@jmmaranan.com" "Vitals@CoreCoding.com" ];
      favorite-apps = [ "Alacritty.desktop" "google-chrome.desktop" "org.keepassxc.KeePassXC.desktop" "org.gnome.Nautilus.desktop" ];
    };
  };

  xresources.properties = {
    "Xcursor.size" = "32";

    "Xterm*faceName" = "monospace";
    "Xterm*faceSize" = "11";
    "Xterm*background" = "#000000";
    "Xterm*foreground" = "#ffffff";
    "Xterm*cursorColor" = "#ffffff";

    "Xft.dpi" = "144";
    "Xft.autohint" = "0";
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = "1";
    "Xft.antialias" = "1";
    "Xft.rgba" = "rgb";
  };

  home.packages = with pkgs; [
    spotify
    google-chrome
    keepassxc
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}
