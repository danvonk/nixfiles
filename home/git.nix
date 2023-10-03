{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "Dan Vonk";
    userEmail = "dan@danvonk.com";
  };
}
