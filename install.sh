#!/usr/bin/env bash

set -e

echo "==> Actualizando sistema..."
sudo pacman -Syu --noconfirm

echo "==> Instalando paquetes base..."

sudo pacman -S --noconfirm \
  xorg-server xorg-xinit xorg-xrandr \
  bspwm sxhkd \
  polybar rofi \
  kitty \
  picom \
  zsh \
  feh \
  xclip \
  firefox \
  thunar \
  ttf-iosevka-nerd

echo "==> Instalando dependencias útiles..."
sudo pacman -S --noconfirm \
  git base-devel

echo "==> Instalando powerlevel10k..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

echo "==> Configurando ZSH como shell por defecto..."
chsh -s $(which zsh)

echo "==> Copiando configuración..."

CONFIG_DIR="$HOME/.config"
REPO_DIR="$(pwd)"

mkdir -p $CONFIG_DIR

# BSPWM
cp -r $REPO_DIR/bspwm $CONFIG_DIR/
chmod +x $CONFIG_DIR/bspwm/bspwmrc

# SXHKD
cp -r $REPO_DIR/sxhkd $CONFIG_DIR/

# KITTY
cp -r $REPO_DIR/kitty $CONFIG_DIR/

# POLYBAR
cp -r $REPO_DIR/polybar $CONFIG_DIR/
chmod +x $CONFIG_DIR/polybar/launch.sh
chmod +x $CONFIG_DIR/polybar/scripts/*.sh

# ROFI
cp -r $REPO_DIR/rofi $CONFIG_DIR/
chmod +x $CONFIG_DIR/rofi/*.sh

# WALLPAPERS
cp -r $REPO_DIR/wallpapers $CONFIG_DIR/

# ZSHRC
cp $REPO_DIR/.zshrc $HOME/

echo "==> Configurando xinit..."

cat > $HOME/.xinitrc << 'EOF'
sxhkd &
picom &
feh --bg-fill ~/.config/wallpapers/deathmaster.jpg &
polybar launch.sh &
exec bspwm
EOF

echo "==> Instalación completada"
echo "Ejecuta 'startx' para iniciar el entorno"
