{
  description = "All of my vim plugins, everywhere, all at once";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
          nvim = pkgs.wrapNeovim pkgs.neovim-unwrapped {
            viAlias = true;
            vimAlias = true;
            configure = {
              customRC = (builtins.readFile ./init.vim);
            };
          };
      in {
        packages.nvim = nvim;
        packages.default = nvim;
      }
    );
}
