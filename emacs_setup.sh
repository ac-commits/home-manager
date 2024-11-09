git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
rm -rf ~/.emacs.d
rm -rf ~/.config/doom
git clone git@github.com:Itrekr/doom.git ~/.config/doom
~/.config/emacs/bin/doom sync
~/.config/emacs/bin/doom build
kill -9 -1
