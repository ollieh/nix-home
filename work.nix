{ config, pkgs, ... }:

let 
  base = import ./home-base.nix { 
    inherit config pkgs;
  };
in 
  base // {
    home.username = "oliver";
    home.homeDirectory = "/home/oliver";
  }
