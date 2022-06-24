# /bin/bash or whatever the fuck it has to say in the first line lmao
# This script copies my configs over from the current system to the repository

# get directory of the repo
BASEDIR=$(dirname $0)

# weird shit like xmonad
# xmonad
cp ${HOME}/.xmonad/xmonad.hs ${BASEDIR}/.xmonad/xmonad.hs

# ~/.config/ files
# xmobar
cp ${HOME}/.config/xmobar/xmobarrc ${BASEDIR}/.config/xmobar/xmobarrc

# alacritty
cp ${HOME}/.config/alacritty/alacritty.yml ${BASEDIR}/.config/alacritty/alacritty.yml

# dunst
cp ${HOME}/.config/dunst/dunstrc ${BASEDIR}/.config/dunst/dunstrc

# fish
cp -r ${HOME}/.config/fish/ ${BASEDIR}/.config/fish/

# micro
cp -r ${HOME}/.config/micro/ ${BASEDIR}/.config/micro/

# qalculate
cp ${HOME}/.config/qalculate/qalc.cfg ${BASEDIR}/.config/qalculate/qalc.cfg

# qutebrowser
cp -r ${HOME}/.config/qutebrowser/ ${BASEDIR}/.config/qutebrowser/

# rofi
cp ${HOME}/.config/rofi/config.rasi ${BASEDIR}/.config/rofi/config.rasi

# /etc/ files
# lightdm (configured for lightdm-mini-greeter)
cp /etc/lightdm/lightdm.conf ${BASEDIR}/etc/lightdm/lightdm.conf
cp /etc/lightdm/lightdm-mini-greeter.conf ${BASEDIR}/etc/lightdm/lightdm-mini-greeter.cinf

# wallpaper (I really like this cute kde wallpaper)
cp -r ${HOME}/Pictures/wallpapers ${BASEDIR}/wallpapers

