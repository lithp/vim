{
  description = "All of my vim plugins, everywhere, all at once";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.copilot = { url = "github:github/copilot.vim"; flake = false; };

  outputs = { self, nixpkgs, flake-utils, copilot }: 
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
          plug-copilot = pkgs.vimUtils.buildVimPluginFrom2Nix {
	     pname = "copilot";
	     version = "master";
	     src = copilot;
	  };
          nvim = pkgs.wrapNeovim pkgs.neovim-unwrapped {
            viAlias = true;
            vimAlias = true;
            configure = {
              customRC = (builtins.readFile ./init.vim);
	      packages.myVimPackage = with pkgs.vimPlugins; {
	        start = [plug-copilot];
	      };
            };
          };
      in {
        packages.nodejs = pkgs.nodejs;
        packages.nvim = nvim;
        packages.default = nvim;
      }
    );
}
