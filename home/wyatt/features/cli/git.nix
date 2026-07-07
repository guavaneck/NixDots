{pkgs, ...}: {
  programs.git = {
    enable = true;

    userName = "Wyatt";
    userEmail = "your-email@example.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoStash = true;
      fetch.prune = true;
      core.editor = "nvim";
    };
  };
]
