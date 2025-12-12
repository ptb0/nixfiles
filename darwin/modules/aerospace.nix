{...}: {
  services.aerospace = {
    enable = true;
    settings = {
      config-version = 2;
      gaps = {
        outer = {
          left = 5;
          right =5;
          top = 5;
          bottom = 5;
        };
	      inner = {
          horizontal = 5;
          vertical = 5;
	      };
      };

      mode.main.binding = {
	      cmd-enter = ''exec-and-forget osascript -e '
                  tell application "iTerm2"
                       create window with default profile
                  end tell'
              '';

	      cmd-s = "layout v_accordion";
        cmd-w = "layout h_accordion";
	      cmd-e = "layout tiles horizontal vertical";

	      cmd-shift-space = "layout floating tiling";

        cmd-minus = "resize smart -50";
        cmd-equal = "resize smart +50";

        cmd-1 = "workspace 1";
        cmd-2 = "workspace 2";
        cmd-3 = "workspace 3";
        cmd-4 = "workspace 4";
        cmd-5 = "workspace 5";
        cmd-6 = "workspace 6";

        cmd-shift-1 = "move-node-to-workspace 1";
        cmd-shift-2 = "move-node-to-workspace 2";
        cmd-shift-3 = "move-node-to-workspace 3";
        cmd-shift-4 = "move-node-to-workspace 4";
        cmd-shift-5 = "move-node-to-workspace 5";
        cmd-shift-6 = "move-node-to-workspace 6";
        
	      cmd-tab = "workspace-back-and-forth";

	      cmd-f = "fullscreen";

        # disable hide window
        cmd-h = [];
        cmd-alt-h = [];
      };

      exec-on-workspace-change = [ "/bin/bash -c" "sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE" ];
      
    };
  };
}
