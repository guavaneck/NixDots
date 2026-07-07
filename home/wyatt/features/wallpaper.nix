{config, pkgs, lib, ...}:
lib.mkIf (config.wallpaper != null) {
  home.packages = [pkgs.swaybg];

  systemd.user.services.swaybg = {
    Unit.Description = "wallpaper";
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} -m fill";
      Restart = "on-failure";
    };
  };
}
