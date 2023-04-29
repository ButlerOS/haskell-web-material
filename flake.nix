{
  nixConfig.bash-prompt = "[nix(material)] ";
  inputs = {
    hspkgs.url =
      "github:podenv/hspkgs/fe0dabfd8acf96f1b5cff55766de6284517868cf";
    # "path:///srv/github.com/podenv/hspkgs";
  };
  outputs = { self, hspkgs }:
    let
      pkgs = hspkgs.pkgs;

      haskellExtend = hpFinal: hpPrev: {
        web-material = hpPrev.callCabal2nix "web-material" self { };
      };
      hsPkgs = pkgs.hspkgs.extend haskellExtend;

      baseTools = with pkgs; [
        hpack
        cabal-install
        hlint
        fourmolu
        weeder
        hsPkgs.doctest
      ];

    in {
      packages."x86_64-linux".default = pkg-exe;
      devShell."x86_64-linux" = hsPkgs.shellFor {
        packages = p: [ p.web-material ];
        buildInputs = with pkgs;
          [ ghcid haskell-language-server nodejs esbuild ] ++ baseTools;
      };
    };
}
