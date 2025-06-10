# 📝 Description
This script automates the installation and configuration of ZSH, Oh My Zsh, Powerlevel10k, and useful plugins for Arch Linux-based systems.

# ✨ Features
Installs ZSH if not present

Sets ZSH as default shell

Installs Oh My Zsh framework

Installs Powerlevel10k theme

Installs popular plugins:

zsh-autosuggestions 🗨️

zsh-syntax-highlighting 🌈

Automatically configures .zshrc

# ⚙️ Requirements
Arch Linux-based system (Arch, Manjaro, EndeavourOS, Garuda, etc.)

Internet connection 🌐

sudo privileges 🔑

# 🛠️ Usage Instructions
Download the script:

```bash
curl -O https://raw.githubusercontent.com/your-user/your-repo/master/zsh-config.sh
```
Make it executable:

```bash
chmod +x zsh-config.sh
```
Run the script:

```bash
./zsh-config.sh
```

Follow the prompts:

Script will ask before making important changes

Will notify if components are already installed

Restart your terminal after installation

Configure Powerlevel10k (optional):

```bash
p10k configure
```
# 📦 Installed Components
Component	Description
ZSH	Advanced shell with better autocomplete features
Oh My Zsh	Configuration management framework for ZSH
Powerlevel10k	Highly customizable theme with fast prompt ⚡
zsh-autosuggestions	Suggests commands as you type based on history 🔍
zsh-syntax-highlighting	Highlights command syntax as you type ✨
# 🎨 Customization
After installation, customize your setup by editing:

```bash
nano ~/.zshrc
```
To customize Powerlevel10k theme:

```bash
nano ~/.p10k.zsh
```
