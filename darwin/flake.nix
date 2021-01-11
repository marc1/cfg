{
    description = "";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; 

        darwin = {
            url = "github:lnl7/nix-darwin/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, ... }@inputs: 
    let
        # mappings of hostnames to darwin configs.
        # for the most part i plan to keep the darwin configuration
        # fairly consistent so i didn't see a reason to make one per-host
        hosts-darwin = builtins.mapAttrs (n: v:
            (inputs.darwin.lib.darwinSystem {
                modules = [ (import ./darwin.nix { hostname="foo"; }) ];
            }).config.system.build.toplevel
        ) (builtins.readDir ../hosts);
    in {
        packages."x86_64-darwin" = hosts-darwin; 
    };
}
