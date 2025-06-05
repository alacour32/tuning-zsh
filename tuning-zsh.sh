#!/bin/bash

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

# Función para verificar si un comando existe
command_exists() {
  command -v "$1" &> /dev/null
}

# Función para instalar un paquete si no está instalado
install_package() {
  local package="$1"
  if ! command_exists "$package"; then
    echo -e "${YELLOW}Instalando $package...${NC}"
    sudo pacman -S --noconfirm "$package" || {
      echo -e "${RED}Error al instalar $package. Abortando.${NC}"
      exit 1
    }
    echo -e "${GREEN}$package instalado correctamente.${NC}"
  else
    echo -e "${GREEN}$package ya está instalado.${NC}"
  fi
}

# Verificar si ZSH está instalado
if command_exists zsh; then
  echo -e "${YELLOW}ZSH ya está instalado.${NC}"
  current_shell=$(basename "$SHELL")
  if [ "$current_shell" != "zsh" ]; then
    echo -e "${YELLOW}ZSH no es tu shell actual (tu shell es $current_shell).${NC}"
    read -p "¿Quieres cambiar a ZSH como shell por defecto? [y/N]: " change_shell
    if [[ "$change_shell" =~ [yY] ]]; then
      chsh -s $(which zsh)
      echo -e "${GREEN}Shell cambiado a ZSH. Reinicia tu terminal para aplicar los cambios.${NC}"
    fi
  else
    echo -e "${GREEN}ZSH ya es tu shell por defecto.${NC}"
  fi
else
  echo -e "${YELLOW}ZSH no está instalado.${NC}"
  read -p "¿Quieres instalar ZSH? [y/N]: " install_zsh
  if [[ "$install_zsh" =~ [yY] ]]; then
    install_package zsh
    chsh -s $(which zsh)
    echo -e "${GREEN}ZSH instalado y configurado como shell por defecto. Reinicia tu terminal.${NC}"
  else
    echo -e "${RED}ZSH no se instalará. Abortando.${NC}"
    exit 1
  fi
fi

# Instalar Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo -e "${YELLOW}Instalando Oh My Zsh...${NC}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
    echo -e "${RED}Error al instalar Oh My Zsh. Abortando.${NC}"
    exit 1
  }
  echo -e "${GREEN}Oh My Zsh instalado correctamente.${NC}"
else
  echo -e "${GREEN}Oh My Zsh ya está instalado.${NC}"
fi

# Instalar Powerlevel10k
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo -e "${YELLOW}Instalando Powerlevel10k...${NC}"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" || {
    echo -e "${RED}Error al clonar Powerlevel10k. Abortando.${NC}"
    exit 1
  }
  # Cambiar tema en .zshrc
  sed -i 's/ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
  echo -e "${GREEN}Powerlevel10k instalado y configurado.${NC}"
else
  echo -e "${GREEN}Powerlevel10k ya está instalado.${NC}"
fi

# Instalar plugins
install_plugin() {
  local plugin_name="$1"
  local plugin_repo="$2"
  local plugin_dir="$HOME/.oh-my-zsh/custom/plugins/$plugin_name"

  if [ ! -d "$plugin_dir" ]; then
    echo -e "${YELLOW}Instalando $plugin_name...${NC}"
    git clone "$plugin_repo" "$plugin_dir" || {
      echo -e "${RED}Error al instalar $plugin_name. Abortando.${NC}"
      exit 1
    }
    echo -e "${GREEN}$plugin_name instalado correctamente.${NC}"
  else
    echo -e "${GREEN}$plugin_name ya está instalado.${NC}"
  fi
}

# Instalar zsh-autosuggestions
install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"

# Instalar zsh-syntax-highlighting
install_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"

# Actualizar .zshrc para incluir plugins
if ! grep -q "plugins=(git" ~/.zshrc; then
  echo -e "${YELLOW}Configurando plugins en .zshrc...${NC}"
  sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
  echo -e "${GREEN}Plugins añadidos al archivo .zshrc.${NC}"
else
  echo -e "${GREEN}Los plugins ya están configurados en .zshrc.${NC}"
fi

# Mensaje final
echo -e "${GREEN}\n¡Todo listo! Reinicia tu terminal para aplicar los cambios.${NC}"
echo -e "${YELLOW}Después del reinicio, ejecuta 'p10k configure' si deseas personalizar Powerlevel10k.${NC}"