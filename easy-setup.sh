#!/bin/bash
echo -e "$(tput bold)Arch Easy Setup Script: V1.3 - 20231223$(tput sgr0)" ; sleep 2

whiptail --title "Arch Easy Setup Script: V1.3 20231223" --msgbox "Hello, and thank you for using my Arch Linux Easy Setup Script. This script allows installing from a choice of minimal desktops, as well as some useful tools, apps and utilities. In the next few screens, you can select what you'd like to install. After that, the rest of the script is fully automatic, so just sit back and relax while I take care of the magic. :)" 16 50

############################
### Set user preferences ###
############################

if whiptail --title "BASH Shortcuts" --yesno "Would you like to add BASH shortcuts?" 8 50 ; then
	SHORT=1
fi

if whiptail --title "Link /home/$USER dirs in /home/common" --yesno "Would you like to set up and link common directories in /home/$USER?" 8 50 ; then
	COMMON=1
fi

if [[ ! -f /usr/bin/yay ]]; then
	REPOS=1
fi

if [[ $REPOS == 1 ]]; then
	if whiptail --title "Install Systemback" --yesno "Would you like to install Systemback?" 8 50 ; then
		SYSBACK=1
	fi
fi

DESKTOP=$(whiptail --title "Desktop Installation Selection" --menu "Which desktop would you like to install?" 15 31 5 \
"KDE" "" \
"Gnome" "" \
"Cinnamon" "" \
"Budgie" "" \
"None at this time" "" 3>&1 1>&2 2>&3)

BROWSER=$(whiptail --title "Web Browser Selection" --menu "Which web browser would you like to install?" 16 30 6 \
"Brave" "" \
"Chrome" "" \
"Edge" "" \
"Firefox" "" \
"Vivaldi" "" \
"None at this time" "" 3>&1 1>&2 2>&3)
if [[ ! $BROWSER == N* ]]; then
	if whiptail --title "Web Browser Installation" --yesno "Woudld you like to actually install $BROWSER, or just configure its common home directories?" 10 50 ; then
		BROWSERINST=1
	fi
fi

GENERAL1=$(whiptail --title "General Applications & Libraries" --checklist "Which general apps and libraries would you like to install? Note: if you change options such as mesa and vulkan, some games and programs may not run if they are not installed! Select CANCEL if you don't want to install anything here. Note: basic packages such as CUPS, and support for NTFS and FAT filesystems are installed by default" 34 40 20 \
libreoffice-fresh "" ON \
wps-office "" OFF \
ttf-ms-fonts "" OFF \
hplip "" OFF \
vlc "" ON \
lutris "" OFF \
wine "" ON \
winetricks "" ON \
vulkan-icd-loader "" ON \
lib32-vulkan-icd-loader "" ON \
vulkan-intel "" ON \
lib32-vulkan-intel "" ON \
vkd3d "" ON \
lib32-vkd3d "" ON \
lib32-alsa-plugins "" ON \
lib32-libpulse  "" ON \
lib32-openal "" ON \
mesa "" ON \
lib32-mesa "" ON \
downgrade "" ON \
3>&1 1>&2 2>&3)
GENERAL=$(echo $GENERAL1 | tr -d "\"")

##########################################
### Confirm all okay before proceeding ###
##########################################

if whiptail --title "Arch Easy Setup Script" --yesno "Would you like the script to run entirely automatically, or confirm each installation step?" 8 55 ; then
	$CONFIRM="--noconfirm"
	else
	$CONFIRM="--canfirm"
fi
if ! whiptail --title "Arch Easy Setup Script" --yesno "Okay, that's all the information I need. Would you like to continue?" 8 50 ; then
	whiptail --title "Arch Easy Setup Script" --msgbox "That's not a problem. You can run the script again if you wish. Have a nice day!" 8 50;  exit 0
fi
clear

##########################
### Add bash shortcuts ###
##########################

if [[ $SHORT == 1 ]]; then
	echo -e "\n\n$(tput bold)Adding bash shortcuts$(tput sgr0)"
	echo -e "alias ls='ls --color=auto -alh'\nalias install='yay -S'\nalias remove='yay -Rcns'\nalias autoremove='yay -Rcns $(yay -Qdttq)'\nalias update='yay -Syu'\nalias search='yay -Ss'\nalias showinst='yay -Qs'\nalias edit='kate'\nalias wipe='yes|yay -Scc >/dev/null ; rm -rf ~/.cache/yay ; rm /home/$USER/.bash_history ; clear ; history -c'\nalias updategrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'\nalias reflector='sudo reflector -c AU --save /etc/pacman.d/mirrorlist'" >> /home/$USER/.bashrc
fi

################################
### Common directories setup ###
################################

if [[ $COMMON == 1 ]]; then

	echo -e "\n\n$(tput bold)Setting up directories in /home/common$(tput sgr0)"
	cd /home
	sudo mkdir common
	sudo chown $USER common
	cd common
	mkdir -p .cache/lutris .cache/wine .cache/winetricks .config/lutris .local/share/lutris Documents Downloads Games Music Pictures Public Templates Videos
		if [[ $BROWSER == B* ]]; then 
			mkdir -p .cache/BraveSoftware .config/BraveSoftware
			rm -rf /home/$USER/.cache/BraveSoftware /home/$USER/.config/BraveSoftware
		fi
		if [[ $BROWSER == C* ]]; then 
			mkdir -p .cache/google-chrome .config/google-chrome
			rm -rf /home/$USER/.cache/google-chrome /home/$USER/.config/google-chrome
		fi
		if [[ $BROWSER == E* ]]; then
			mkdir -p .cache/Microsoft .cache/microsoft-edge .config/microsoft-edge
			rm -rf /home/$USER/.cache/Microsoft /home/$USER/.cache/microsoft-edge /home/$USER/.config/microsoft-edge
		fi
		if [[ $BROWSER == F* ]]; then
			mkdir -p .cache/mozilla .mozilla
			rm -rf /home/$USER/.cache/mozilla /home/$USER/.mozilla
		fi
		if [[ $BROWSER == V* ]]; then 
			mkdir -p .cache/vivaldi .config/vivaldi
			rm -rf /home/$USER/.cache/vivaldi /home/$USER/.config/vivaldi
		fi


	rm -rf /home/$USER/.cache/lutris /home/$USER/.cache/wine /home/$USER/.cache/winetricks /home/$USER/.config/lutris /home/$USER/.local/share/lutris

	cd /home/$USER
	rm -rf Documents Downloads Games Music Pictures Public Templates Videos
	
	cd /home/$USER/.cache
	
	# Browser-specific dirs in /home/common (Brave, Chrome, Firefox, Edge or Vivaldi)
	if [[ $BROWSER == B* ]]; then
		ln -s /home/common/.cache/BraveSoftware .
	fi
	if [[ $BROWSER == C* ]]; then
		ln -s /home/common/.cache/google-chrome .
	fi
	if [[ $BROWSER == E* ]]; then
		ln -s /home/common/.cache/Microsoft . ; ln -s /home/common/.cache/microsoft-edge .
	fi
	if [[ $BROWSER == F* ]]; then
		ln -s /home/common/.cache/mozilla .
	fi
	if [[ $BROWSER == V* ]]; then
		ln -s /home/common/.cache/vivaldi .
	fi
	
	ln -s /home/common/.cache/lutris ; ln -s /home/common/.cache/wine ; ln -s /home/common/.cache/winetricks


	cd /home/$USER/.config
	if [[ $BROWSER == B* ]]; then
		ln -s /home/common/.config/BraveSoftware
	fi
	if [[ $BROWSER == C* ]]; then
		ln -s /home/common/.config/google-chrome
	fi
	if [[ $BROWSER == E* ]]; then
		ln -s /home/common/.config/microsoft-edge
	fi
	if [[ $BROWSER == F* ]]; then
		cd /home/$USER ; ln -s /home/common/.mozilla
	fi
	if [[ $BROWSER == V* ]]; then
		ln -s /home/common/.config/vivaldi
	fi
	ln -s /home/common/.config/lutris

	
	cd /home/$USER/.local/share
	ln -s /home/common/.local/share/lutris
	
	cd /home/$USER
	ln -s /home/common/Documents ; ln -s /home/common/Downloads ; ln -s /home/common/Games ; ln -s /home/common/Music ; ln -s /home/common/Pictures ; ln -s /home/common/Public ; ln -s /home/common/Templates ; ln -s /home/common/Videos
fi

##########################################
### Add Systemback & Chaotic-AUR repos ###
##########################################

if [[ $REPOS == 1 ]]; then
	cp /etc/pacman.conf .
	
	# Add Systemback entries to pacman.conf
	
	if [[ $SYSBACK == 1 ]] ; then
		echo -e "\n\n$(tput bold)Adding Systemback to pacman.conf$(tpug sgr0)"
		echo -e '\n[yuunix_aur]\nSigLevel = Optional TrustedOnly\nServer = https://shadichy.github.io/$repo/$arch' >> ./pacman.conf
	fi
	
	# Add Chaotic-AUR entries to pacman.conf
	echo -e "\n\n$(tput bold)Adding chaotic-AUR to pacman.conf$(tput sgr0)"
	
	sudo pacman-key --recv-key 3056513887B78AEB
	sudo pacman-key --lsign-key 3056513887B78AEB
	sudo pacman -U $CONFIRM 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
	sudo pacman -U $CONFIRM 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
	echo -e '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' >> ./pacman.conf
	
	sudo cp -r ./pacman.conf /etc; rm ./pacman.conf
	
	# Install yay
	sudo pacman -Sy $CONFIRM yay
fi

##########################
### Install Systemback ###
##########################

if [[ $SYSBACK == 1 ]]; then
	echo -e "\n\n$(tput bold)Installing Systemback$(tput sgr0)"
	yay -S $CONFIRM systemback
fi


############################
### Desktop Installation ### 
############################


### Install minimal KDE ###
if [[ $DESKTOP == K* ]]; then
	echo -e "\n\n$(tput bold)Installing minimal KDE Desktop$(tput sgr0)"
	yay -S $CONFIRM sddm sddm-kcm breeze-gtk networkmanager nm-connection-editor plasma-nano plasma-wayland-session plasma-nm plasma-pa kdeplasma-addons discover packagekit-qt5 kde-gtk-config systemsettings powerdevil bluez bluedevil konsole dolphin yakuake kscreen kmix kate mc kio-gdrive plasma5-applets-kde-arch-update-notifier wget
	sudo systemctl enable sddm
fi

### Install minimal Gnome ###
if [[ $DESKTOP == G* ]]; then
	echo -e "\n\n$(tput bold)Installing minimal Gnome Desktop and extensions$(tput sgr0)"
	yay -S $CONFIRM gdm wget
	yay -S $CONFIRM gnome-shell gnome-terminal gnome-tweak-tool gnome-control-center xdg-user-dirs xdg-desktop-portal-gnome eog gnome-menus gnome-browser-connector gnome-screenshot gnome-shell-extensions gnome-tweaks nemo nemo-terminal gnome-themes-extra extension-manager gnome-shell-extension-arc-menu gnome-shell-extension-gtk4-desktop-icons-ng gnome-shell-extension-arch-update gnome-shell-extension-bing-wallpaper gnome-shell-extension-dash-to-panel gnome-shell-extension-weather-oclock-git guake alacarte mc kate evince seahorse qgnomeplatform-qt5 qgnomeplatform-qt6 qt5-wayland qt6-wayland gnome-keyring gvfs-google seahorse # gdm gnome-shell-extension-smart-auto-move-git ## disabled as extension not compatible with Gnome 45

	# Install beta/test version of Smart Auto Move - props to ionutbortis, nice work mate! :)
	wget https://github.com/khimaros/smart-auto-move/files/13418637/smart-auto-move%40khimaros.com.shell-extension.zip
	gnome-extensions install --force smart-auto-move@khimaros.com.shell-extension.zip

	sudo systemctl enable gdm

	# Disable power-off and logout confirmation prompts (60 second timer)
	gsettings set org.gnome.SessionManager logout-prompt false
	
	# Enable extensions
	echo -e "\n\n$(tput bold)Activating installed Gnome extensions$(tput sgr0)"
	gnome-extensions enable arch-update@RaphaelRochet
	gnome-extensions enable arcmenu@arcmenu.com
	gnome-extensions enable dash-to-panel@jderose9.github.com
	gnome-extensions enable ding@rastersoft.com
	gnome-extensions enable smart-auto-move@khimaros.com
	gnome-extensions enable weatheroclock@CleoMenezesJr.github.io
fi

### Install minimal Cinnamon ###
if [[ $DESKTOP == C* ]]; then
	echo -e "\n\n$(tput bold)Installing Cinnamon Desktop$(tput sgr0)"
	yay -S $CONFIRM cinnamon lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings featherpad nemo-terminal gnome-terminal wget
	sudo systemctl enable lightdm
fi

### Install minimal Budgie ###
if [[ $DESKTOP == B* ]]; then
	echo -e "\n\n$(tput bold)Installing Budgie Desktop$(tput sgr0)"
	yay -S $CONFIRM budgie-desktop lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings gedit wget
	sudo systemctl enable lightdm
fi

################################
### Install general software ###
################################

	echo -e "\n\n$(tput bold)Installing general software and libraries$(tput sgr0)"
	echo $GENERAL
	yay -S $CONFIRM system-config-printer cups libdvdread libdvdcss libcdio exfat-utils ntfs-3g sof-firmare $GENERAL
	sudo systemctl enable cups.service; sudo systemctl start cups.service


###########################
### Install Web Browser ###
###########################

if [[ $BROWSERINST == 1 ]]; then
	if [[ $BROWSER == B* ]]; then
		echo -e "\n\n$(tput bold)Installing Brave as default web browser$(tput sgr0)"
		yay -S $CONFIRM brave-bin
	fi
	if [[ $BROWSER == C* ]]; then
		echo -e "\n\n$(tput bold)Installing Google Chrome as default web browser$(tput sgr0)"
		yay -S $CONFIRM google-chrome
	fi
	if [[ $BROWSER == E* ]]; then
		echo -e "\n\n$(tput bold)Installing Microsoft Edge as default web browser$(tput sgr0)"
		yay -S $CONFIRM microsoft-edge-stable-bin
	fi
	if [[ $BROWSER == F* ]]; then
		echo -e "\n\n$(tput bold)Installing Firefox as default web browser$(tput sgr0)"
		yay -S $CONFIRM firefox
	fi
		if [[ $BROWSER == V* ]]; then
		echo -e "\n\n$(tput bold)Installing Vivaldi as default web browser$(tput sgr0)"
		yay -S $CONFIRM vivaldi
	fi
fi


##############
### Finish ###
##############

echo -e "\n\n$(tput bold)*** Script execution completed ***$(tput sgr0)"
sudo systemctl enable NetworkManager.service ; sudo systemctl start NetworkManager.service
yes|yay -Scc >>/dev/null
sleep 5; if whiptail --title "And that's a wrap!" --yesno "All done! Would you like to reboot the system now (highly recommended if you have installed any software)?" 9 50 ; then
	reboot
fi
