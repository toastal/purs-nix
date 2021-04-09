{ ps-pkgs, ps-pkgs-ns }@pkgs:
  with ps-pkgs;
  { ursi =
      { debug = import ((builtins.fetchGit { rev = "c57b867dd6403dba3223e5db28c82c351757f4df"; url = "https://github.com/ursi/purescript-debuggest.git"; }) + /package.nix) pkgs;
        elmish = import ((builtins.fetchGit { rev = "47deb688c8ec62e15d7dc1264e39998633761803"; url = "https://github.com/ursi/purescript-elmish.git"; }) + /package.nix) pkgs;

        ffi-options =
          { repo = "https://github.com/ursi/purescript-ffi-options.git";
            rev = "568f213577549e958f931f4d9e7dc7c57bf5fadc";
          };

        html = import ((builtins.fetchGit { rev = "7eecd40cceeb03ade75ba7268b3befae0580d3c9"; url = "https://github.com/ursi/purescript-whatwg-html.git"; }) + /package.nix) pkgs;
        task-file = import ((builtins.fetchGit { rev = "b8956d010f28aa2c5ae5bfd8ffab17b484548075"; url = "https://github.com/ursi/purescript-task-file.git"; }) + /package.nix) pkgs;
        prelude = import ((builtins.fetchGit { rev = "281d8e7ab24ff840b08608d2d8ded457daf88b0d"; url = "https://github.com/ursi/purescript-mason-prelude.git"; }) + /package.nix) pkgs;
      };
  }