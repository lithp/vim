# vim
A nix flake for my vim setup

```bash
# Try it out, single command:
# (`nix run` caches the build between calls, it's only slow the first time)
nix --extra-experimental-features 'nix-command flakes' run github:lithp/vim

# A little more convenient:
mkdir -p ~/.config/nix
echo 'extra-experimental-features = nix-command flakes' >>~/.config/nix/nix.conf
nix run github:lithp/vim

# `nix run` makes a network request to github on every call,
# this command locks in a version and installs `vi`, `vim` and `nvim` aliases:
nix profile install github:lithp/vim

# after running the above these commands are useful:
nix profile list
nix profile upgrade SOME_SMALL_INTEGER
```
