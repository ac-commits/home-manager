{ config, pkgs, ... }:

let
  # Define a Python environment with necessary packages
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [ requests ]);
in
{
  # Define the systemd user service
  systemd.user.services.readwise = {
    Unit = {
      Description = "Run readwise.py script";
    };
    Service = {
      ExecStart = "${pythonEnv.interpreter} /home/oscar/Mimisbrunnr/Notes/readwise.py";
      WorkingDirectory = "/home/oscar/Mimisbrunnr/Notes";
      Restart = "always";
      RestartSec = 60;
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Define the systemd user timer to run the service every minute
  systemd.user.timers.readwise = {
    Unit = {
      Description = "Run readwise.py every minute";
    };
    Timer = {
      OnCalendar = "*:0/1";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
