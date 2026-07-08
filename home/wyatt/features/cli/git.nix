{pkgs, ...}: {
  programs.git = {
    enable = true;

    settings = {
      user.name = "guava";
      user.email = "wszyjka@charlotte.com";

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoStash = true;
      fetch.prune = true;
      core.editor = "nvim";

    };

    ignores = [
      ".direnv/"
      "result"
      "result-*"
      ".DS_Store"
      "*.swp"
    ];
  };
  programs.delta = {
    enable = true;
    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = true;
    };
  };
}
