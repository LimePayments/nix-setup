{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2020-05-08";
  # Commit hash for nixos-unstable as of 2020-05-08 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/d78ba41a5604c8e06d40756a2436e52169354d36.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0bk81ddx1iq8i0nhg1i44kllihphyzhbc416zgylli0ycphknrkv";}) {};

let
  dummy = dummy;
in
  stdenv.mkDerivation rec {
    name = "Node.js";

    buildInputs = [
      nodejs
    ];

    shellHook = ''
    '';
  }
