{ config, pkgs, ... }:

let 
  customVimPlugins = {
    vim-buftabline = pkgs.vimUtils.buildVimPlugin {
      name = "vim-buftabline";
      src = pkgs.fetchFromGitHub {
        owner = "ap";
        repo = "vim-buftabline";
        rev = "73b9ef5dcb6cdf6488bc88adb382f20bc3e3262a";
        sha256 = "1vs4km7fb3di02p0771x42y2bsn1hi4q6iwlbrj0imacd9affv5y";
      };
    };
  };
  vimPlugins = pkgs.vimPlugins // customVimPlugins;
in 
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  fonts.fontconfig.enable = true;
  home.username = "ollie";
  home.homeDirectory = "/home/ollie";
  programs.zsh = {
    enable = true;
    initExtra = ''
      export EDITOR=nvim
      eval "$(starship init zsh)"
      export FZF_DEFAULT_COMMAND='fd --type f'
      export LOCALE_ARCHIVE_2_11="$(nix-build --no-out-link "<nixpkgs>" -A glibcLocales)/lib/locale/locale-archive"
      export LOCALE_ARCHIVE_2_27="$(nix-build --no-out-link "<nixpkgs>" -A glibcLocales)/lib/locale/locale-archive"
      export LOCALE_ARCHIVE="/usr/bin/locale"
      for file in ~/.zsh_extra/*; do
          . "$file"
      done
      export PATH=$PATH:~/go/bin:~/.local/bin
    '';
    oh-my-zsh = {
        enable = true;
        plugins = ["git" "fzf"];
    };
    shellAliases = {
      ls = "exa -G  --color auto --icons -a -s type";
      ll = "exa -l --color always --icons -a -s type";
      cat = "bat -pp --theme=Nord";
    };
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./config/init.vim;
    plugins = with vimPlugins; [
      vim-buftabline
      vim-colorschemes
      onedark-vim
      nord-vim
      tmux-navigator
      coc-nvim
      coc-rls
      fzf-vim
      vim-grepper
      vim-surround
      vim-commentary
      vim-unimpaired
      vim-eunuch
      vim-sneak
      vim-fireplace
      vim-toml
      vim-yaml
      vim-nix
      rust-vim
      julia-vim
    ];
    configure = {};
  };
  home.file = {
    ".tmux.conf".source = ./config/tmux.conf;
    ".ghc/ghci.conf".source = ./config/ghci.conf;
    ".julia/config/startup.jl".source = ./config/startup.jl;
    ".gitconfig".source = ./config/gitconfig;
    ".local/share/gnome-shell/extensions/bitcoin-markets@ottoallmendinger.github.com".source = builtins.fetchGit {
      url = "https://github.com/OttoAllmendinger/gnome-shell-bitcoin-markets.git";
    };
    ".local/share/gnome-shell/extensions/freon@UshakovVasilii_Github.yahoo.com".source = builtins.fetchGit {
      url = "https://github.com/UshakovVasilii/gnome-shell-extension-freon.git";
    } + "/freon@UshakovVasilii_Github.yahoo.com";
    ".local/share/gnome-shell/extensions/tray-icons@zhangkaizhao.com".source = builtins.fetchGit {
      url = "https://github.com/zhangkaizhao/gnome-shell-extension-tray-icons.git";
    };
  };
  xdg.configFile = {
    "starship.toml".text = ''
      add_newline = false
      [kubernetes]
      disabled = true
      [aws]
      disabled = true
      [gcloud]
      disabled = true
    '';
    "alacritty/alacritty.yml".source = ./config/alacritty.yml;
    "termite/config".source = ./config/termite/config;
    "restic/excludes.txt".source = ./config/restic-excludes.txt;
    "compton/compton.conf".source = ./config/compton/compton.conf;
    "i3/config".source = ./config/i3/config;
    "mako/config".source = ./config/mako/config;
    "polybar/config".source = ./config/polybar/config;
    "sway/config".source = ./config/sway/config;
    "swaylock/config".source = ./config/swaylock/config;
    "waybar/config".source = ./config/waybar/config;
    "waybar/executable_mediaplayer.sh".source = ./config/waybar/executable_mediaplayer.sh;
    "waybar/style.css".source = ./config/waybar/style.css;
  };
  home.packages = with pkgs; [
    git
    zsh
    tmux
    fd
    fzf
    jo
    ripgrep
    exa
    bat
    starship
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell".enabled-extensions = [
        "bitcoin-markets@ottoallmendinger.github.com"
        "freon@UshakovVasilii_Github.yahoo.com"
        "tray-icons@zhangkaizhao.com"
      ];
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
