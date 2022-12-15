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
	  # wrapNeovim defined in github:nixos/nixpkgs:pkgs/top-level/all-packages.nix
          nvim = pkgs.wrapNeovim pkgs.neovim-unwrapped {
            viAlias = true;  # see pkgs/applications/editors/neovim/utils.nix
            vimAlias = true;
	    extraMakeWrapperArgs = ''--prefix PATH : ${pkgs.lib.makeBinPath [
	      pkgs.ripgrep pkgs.fd  # telescope
	      pkgs.nodejs-16_x      # copilot
	      pkgs.rust-analyzer    # use by ale
	    ]}'' ;
            configure = {
              customRC = (builtins.readFile ./init.vim);
	      packages.myVimPackage = with pkgs.vimPlugins; {
	        # a big list of these is in pkgs/applications/editors/vim/plugins/
	        start = [
			plug-copilot
			plenary-nvim     # required by telescope
			telescope-nvim   # Unite-replacement, quick navigation
			nvim-treesitter
			ale              # linter & auto-complete
		];
	      };
            };
          };
      in {
        packages.nvim = nvim;
        packages.default = nvim;
      }
    );
}
