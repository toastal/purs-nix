{ make-shell, purs-nix, pkgs, ... }:
  let
    inherit (purs-nix) ps-pkgs;

    ps =
      purs-nix.purs
        { dependencies =
            with ps-pkgs;
            [ console
              effect
              prelude
              (purs-nix.build
                 { name = "node-glob-basic";
                   version = "1.2.0";
                   repo = "https://github.com/natefaubion/purescript-node-glob-basic.git";
                   rev = "22b374b30537a945310fb8049f5bce1b51a7a669";

                   dependencies =
                     with ps-pkgs;
                       [ aff
                         console
                         effect
                         lists
                         maybe
                         node-fs-aff
                         node-path
                         node-process
                         ordered-collections
                         strings
                       ];
                 }
              )
            ];

          test-dependencies = [ ps-pkgs."assert" ];
          srcs = [ ./src ./src2 ];

          foreign.Forn =
            { derivation = pkgs.runCommand "my-js" {} "mkdir $out; ln -s ${./my-js.js} $out/my-js.js";
              paths.myJs = /my-js.js;
            };
        };
  in
  { defaultPackage = ps.modules.Main.app { name = "test"; };

    packages =
      with ps.modules.Forn;
      { bundle = bundle { esbuild.format = "cjs"; esbuild.platform = "node"; main = false; };
        output = output {};
      };

    devShell =
      make-shell
        { packages =
            with pkgs;
            [ nodejs

              (ps.command
                 { name = "purs-nix-test";
                   package = import ./package.nix purs-nix;
                   srcs = [ "src" "src2" ];
                 }
              )

              purs-nix.esbuild
              purs-nix.purescript
              purs-nix.purescript-language-server
            ];
        };
  }

