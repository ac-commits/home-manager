{ pkgs, ... }:
let
  # Define the Python environment with the required packages
  python_env = pkgs.python3.withPackages (ps: with ps; [
    requests
    numpy
    # Add any other dependencies here
  ]);
in
{
  home.file = {
    ".config/systemd/user/readwise.service".text = ''
[Unit]
Description=Run the readwise script

[Service]
Type=oneshot
ExecStart=${python_env}/bin/python3 /home/oscar/Mimisbrunnr/Notes/readwise.py
Environment=PYTHONPATH=${python_env}/lib/python3.10/site-packages
'';

    ".config/systemd/user/readwise.timer".text = ''
[Unit]
Description=Run the readwise script every minute

[Timer]
OnUnitActiveSec=1m
Unit=readwise.service

[Install]
WantedBy=timers.target
'';
  };
}
