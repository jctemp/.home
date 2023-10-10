{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -l";
      l = "ls -lA";
      la = "ls -la";
      dev = "nix develop";
    };
  };
}
