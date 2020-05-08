{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2020-05-08";
  # Commit hash for nixos-unstable as of 2020-05-08 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/d78ba41a5604c8e06d40756a2436e52169354d36.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0bk81ddx1iq8i0nhg1i44kllihphyzhbc416zgylli0ycphknrkv";}) {};

let
  use-jdk = jdk8;
  pkgs = import <nixpkgs> { overlays = [ (self: super: {
    jdk = use-jdk;
    jre = use-jdk;
  }) ]; }; 
  gcptools = google-cloud-sdk;
in
  stdenv.mkDerivation rec {
    name = "Dataflow";

    buildInputs = [
      #figlet
      use-jdk
      sbt
      bloop
      ammonite
      gradle
      maven

      gcptools
    ];

    shellHook = ''
      # in .zshrc:
      #
      # if [[ ! -z <DOLLAR>{LPZSH_GCP_COMPLETER} ]]; then
      #   echo Enabling GCP CLI completion
      #   source <DOLLAR>{LPZSH_GCP_COMPLETER}
      # fi
      export LPZSH_GCP_COMPLETER="${gcptools}/google-cloud-sdk/completion.zsh.inc"

      #figlet -w 160 "${name}"
    '';
  }
