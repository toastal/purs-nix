let inputs = import ./inputs.nix; in
{ extension ? _: {}
, pkgs ? (inputs system).pkgs
, system ? builtins.currentSystem
}:
  import ./purs-nix.nix { inherit extension pkgs system; }
