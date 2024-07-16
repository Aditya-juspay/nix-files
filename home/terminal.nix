{ pkgs, ... }:

# Platform-independent terminal setup
{
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # Unix tools
    ripgrep # Better `grep`
    fd
    sd
    tree

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt
    nixci

    # Dev
    just
    lazygit # Better git UI
    tmate

    nix-health
  ];

  home.shellAliases = {
    g = "git";
    lg = "lazygit";
    k = "kubectl";
    klogs = "k logs -f";
    kgp = "k get pods";
    kgcj = "k get cj";
    gs = "git status";
    ga = "git add";
    gco = "git checkout";
  };

  # Programs natively supported by home-manager.
  programs = {
    bat.enable = true;
    # Type `z <pat>` to cd to some directory
    zoxide.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = true;
    jq.enable = true;
    htop.enable = true;

    # command-not-found handler to suggest nix way of installing stuff.
    # FIXME: This ought to show new nix cli commands though:
    # https://github.com/nix-community/nix-index/issues/191
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    # on macOS, you probably don't need this
    bash = {
      enable = true;
      initExtra = ''
                # Make Nix and home-manager installed things available in PATH.
                export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
        	export PAYMENT_LINKS_ENCRYPTION_KEY=9qvGlV0DZVpVEnynWJ6kew
        	export ENSURE_PS_COMPAT=True
      '';
    };

    # For macOS's default shell.
    zsh = {
      enable = true;
      envExtra = ''
                # Make Nix and home-manager installed things available in PATH.
                export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
        	export PAYMENT_LINKS_ENCRYPTION_KEY=9qvGlV0DZVpVEnynWJ6kew
        	export ENSURE_PS_COMPAT=True
        	export IS_LOCAL_TESTING=True
        	source MySshConfigs
      '';
    };

    # https://zero-to-flakes.com/direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # https://nixos.asia/en/git
    git = {
      enable = true;
      # userName = "John Doe";
      # userEmail = "johndoe@example.com";
      extraConfig = {
        # init.defaultBranch = "master";
      };
    };
  };
}
