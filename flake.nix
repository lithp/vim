{
  description = "All of my vim plugins, everywhere, all at once";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
          vim  = pkgs.vim_configurable.customize {
            vimrcFile = ./vimrc;
          }; in
      {
        packages.vim = vim;
        packages.default = vim;
      }
    );
}
