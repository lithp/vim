{
  description = "All of my vim plugins, all at once";

  inputs = {
	nixpkgs.url = github:NixOS/nixpkgs;
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.vim = nixpkgs.legacyPackages.x86_64-linux.vim;

    packages.x86_64-linux.default = self.packages.x86_64-linux.vim;

  };
}
