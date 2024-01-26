# /bin/bash or whatever the fuck it has to say in the first line lmao
# This script copies my configs over from the current system to the repository

# get directory of the repo
BASEDIR=$(dirname $0)

# weird shit like xmonad
# xmonad
DIRECTORY=${BASEDIR}/.xmonad/
if [ ! -d "$DIRECTORY" ]; then
  mkdir ${DIRECTORY}
fi
cp ${HOME}/.xmonad/xmonad.hs ${BASEDIR}/.xmonad/xmonad.hs

# ~/.config/ files
DIRECTORY=${BASEDIR}/.config/
if [ ! -d "$DIRECTORY" ]; then
  mkdir ${DIRECTORY}
fi
# xmobar
DIRECTORY=${BASEDIR}/.config/xmobar/
if [ ! -d "$DIRECTORY" ]; then
  mkdir ${DIRECTORY}
fi
cp ${HOME}/.config/xmobar/xmobarrc ${BASEDIR}/.config/xmobar/xmobarrc

# alacritty
DIRECTORY=${BASEDIR}/.config/alacritty/
if [ ! -d "$DIRECTORY" ]; then
  mkdir ${DIRECTORY}
fi
cp ${HOME}/.config/alacritty/alacritty.yml ${BASEDIR}/.config/alacritty/alacritty.yml

# dunst
DIRECTORY=${BASEDIR}/.config/dunst/
if [ ! -d "$DIRECTORY" ]; then
  mkdir ${DIRECTORY}
fi
cp ${HOME}/.config/dunst/dunstrc ${BASEDIR}/.config/dunst/dunstrc

# fish
cp -r ${HOME}/.config/fish/ ${BASEDIR}/.config/

# micro
cp -r ${HOME}/.config/micro/ ${BASEDIR}/.config/

# qalculate
DIRECTORY=${BASEDIR}/.config/qalculate
if [ ! -d "$DIRECTORY" ]; then
  mkdir ${DIRECTORY}
fi
cp ${HOME}/.config/qalculate/qalc.cfg ${BASEDIR}/.config/qalculate/qalc.cfg

# qutebrowser
cp -r ${HOME}/.config/qutebrowser/ ${BASEDIR}/.config/

# rofi
DIRECTORY=${BASEDIR}/.config/rofi/
if [ ! -d "$DIRECTORY" ]; then
  mkdir ${DIRECTORY}
fi
cp ${HOME}/.config/rofi/config.rasi ${BASEDIR}/.config/rofi/config.rasi

# nvim
DIRECTORY=${BASEDIR}/.config/nvim/
if [ ! -d "$DIRECTORY" ]; then
  mkdir ${DIRECTORY}
fi
cp ${HOME}/.config/nvim/init.vim ${DIRECTORY}/init.vim

# /etc/ files
DIRECTORY=${BASEDIR}/etc/
if [ ! -d "$DIRECTORY" ]; then
  mkdir ${DIRECTORY}
fi
# lightdm (configured for lightdm-mini-greeter)
DIRECTORY=${BASEDIR}/etc/lightdm/
if [ ! -d "$DIRECTORY" ]; then
  mkdir ${DIRECTORY}
fi
cp /etc/lightdm/lightdm.conf ${BASEDIR}/etc/lightdm/lightdm.conf
cp /etc/lightdm/lightdm-mini-greeter.conf ${BASEDIR}/etc/lightdm/lightdm-mini-greeter.conf

# wallpaper (I really like this cute kde wallpaper)
cp -r ${HOME}/Pictures/wallpapers ${BASEDIR}/

# homepage
cp ${HOME}/home.html ${BASEDIR}/

# wlan0_active.sh script
cp ${HOME}/bin/wlan0_active.sh ${BASEDIR}/

# wifimenu.sh script
cp ${HOME}/.local/bin/wifimenu.sh ${BASEDIR}/

