{ lib, ... }:

{
  # your niri config, generated from the repo
  xdg.configFile."niri/config.kdl".source = ../configs/niri/config.kdl;

  # niri includes this file and amane rewrites it, so it has to be a normal writable file,
  # and it has to exist before niri starts or niri reports a config error
  home.activation.amaneColors = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "$HOME/.config/niri"

    if [ ! -e "$HOME/.config/niri/amane-colors.kdl" ]; then
      run cp ${../configs/niri/amane-colors.kdl} "$HOME/.config/niri/amane-colors.kdl"
      run chmod u+w "$HOME/.config/niri/amane-colors.kdl"
    fi
  '';
}
