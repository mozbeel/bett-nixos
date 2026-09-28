{
  description = "mozbeel";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    ...
  }@inputs:
  let
    system = "x86_64-linux";
    
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      
      config = {
        allowUnfree = true;
        cudaSupport = (import ./meta.nix).cuda;
      };
    };

    nixosSystem =
      module: overrideMeta:
      let
        updatedMeta = (import ./meta.nix) // overrideMeta;
        specialArgs = {
          inherit inputs pkgs-unstable;
        };
      in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = specialArgs // {
          meta = updatedMeta;
        };
        modules = [ module ];
      };
  in
  {
    nixpkgs.config.permittedInsecurePackages = [
      "qtwebengine-5.15.19"
    ];

    # ewaste, smog, warrig, mainframe
    # kraftwerk, stahlwerk, rauchkammer, schrottplatz
    nixosConfigurations = {
      schrottplatz = nixosSystem ./machines/schrottplatz/nixos {
        hostname = "schrottplatz";
      };
    };
  };
}
