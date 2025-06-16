# Arch Linux Easy Setup script
A fairly simple and easily customisable shell script to automate some initial desktop setup after a clean installation of Arch Linux

# UPDATE - May 2025 - Prebuilt live ISO (with KDE Desktop) now available!

As a small gift to the Arch Linux community, I am now providing a pre-built live ISO created using this script, with KDE Desktop. The ISO can be used to boot a live Arch Linux environment, and also includes Systemback, which can be used to install the system. Systemback's installer is arguably one of the simplest and most straightforward Linux installers ever, admittedly at the expense of flexibility. All you need to do is provide a username and password for the user account, as well as a root account password (strongly recommended).

The installed system is very minimal; it only includes basic KDE essentials such as Dolphin, Konsole etc. You can always install other tools, utilities and so on, as you see fit, after completing the installtion. Firefox is included as a web browser.

### Steps to complete an installation using this ISO:

1. Download the ISO [here (Google Drive)](https://drive.google.com/drive/folders/1pxjs_qWDrLdyQw-19yumowIRSmU6grrX?). Unless you are installing into a VM, copy the ISO onto a USB stick, or better yet, use a Ventoy-enabled USB stick.
2. Boot into the live system from the ISO. _Note: at the time of writing, the option to boot directly to the system installer is not currently working. It will just load the main live system._
3. Once the live environment has booted, open Systemback (round green icon on taskbar next to the start menu).
4. Click **System Install** in the menu on the right-hand side of the Systemback window.
5. Fill in the user details on the next screen - name for the user, login username and password. **Adding a password for "root" is strongly recommended**. Also enter a hostname (this can be anything, I usually just use my login username.), then click **Next**.
6. On the next page, you can create/delete and assign partitions. Click on the partition you want to modify, make the changes you want, then click the green "<" button to commit the changes. Make sure you have at least a root (/) partition - 20GB is a good size. I also recommend a separate /home partition, and if you have less than 8GB RAM, you may want to consider a swap partition as well. **Please note this screen also lets you delete existing partitions ... you have been warned! :)**
7. Once you're ready, click **Next**. You'll see a confirmation that you'd like to proceed, then the installation will begin. Just wait for the progress bar to fill, then if all goes well you'll see a notification that the install has been coompleted, after which you can reboot into your fresh new Arch Linux installation!

### You can download the latest version of the ISO [here (Google Drive)](https://drive.google.com/drive/folders/1pxjs_qWDrLdyQw-19yumowIRSmU6grrX?). As always, if you use this ISO, you do so at your own risk - I am not responsible for the results! My goal is update the ISO roughly monthly, as and when time permits.

# IMPORTANT - Please read before trying the script

<b><i>This script does NOT install Arch Linux itself.</b></i> It is not a replacement for tools such as archinstall, and is not intended as such - at least not yet. Its purpose is to quickly and easily set up the system and install basic apps (eg web browser) <i>after</i> Arch Linux itself has been installed. Archinstall as it stands is an excellent tool to make installing Arch easy, and I don't see any point in reinventing the wheel.

The script is written with minimalism in mind - that is, only installing what is necessary without sacrificing on usability. For this reason, I recommend running archinstall to install Arch itself (before running this script), and <b>not installing any desktop environment</b> during the archinstall process. This script will take care of that for you.

The desktop environment you select will be installed as minimally as possible - if you choose Gnome for example, only the core of the Gnome desktop will be installed. Extra components, such as standard utilities and games that are normally present in a Gnome installation, will <i>not</i> be installed. Of course, you are welcome to modify the script to install something by default if you wish, or just proceed to install anything you want after the script has completed.

# Introduction

I have created a BASH script intended to be used immediately after a basic Arch installation, that automatically installs a minimal desktop and some general applications (eg system tools like yay, web browser, office suite, some of my favourite Gnome extensions etc) and sets up links to my /home/common directory. It also sets up access to chaotic-aur, andontie-aur and Systemback repositories.

The script offers a few choices before it starts installing stuff such as which browser you want to install, whether you want links to directories in /home/common created, and then you just sit back and relax while it does its magic. Then reboot ... and everything is all set up and configured, ready to rock and roll!

The inspiration for this script was to provide a flexible and customisable Arch installation (and provide me with learning more advanced BASH scripting), while catering to the different needs of different people. Of course it's not possible to cater to every desire of every user, so I offer no apologies if the script as it stands doesn't offer to install all your favourite applications. I created it mainly for my personal use, but have decided to share it with anyone that wants to use it. Please feel free to modify the script as you see fit. Most options are configured via Whiptail menus, which are quite easy to customise and modify. I've tried to keep the code as clean as possible, so it should be easy enough for someone with at least an intermediate knowledge of BASH scripting to see how it works, and tweak it to suit themselves.

I recommend you review the script before running it, to ensure it meets your needs --- and that it doesn't do anything you don't want it to do! :)

# Usage
The script is intended to be used immediately after a fresh install of Arch Linux - either via archinstall script or (for the purists) a manually configured installation. I would suggest downloading the script (```easy-setup.sh```) and saving it to a USB drive or similar before starting your Arch Linux installation.

When installing Arch Linux with archinstall, I would suggest selecting just "xorg/xserver" as your profile for installation, rather than installing/configuring a DE (Gnome, KDE, Cinnamon etc) within archinstall. My script provides for installation and configuration of your choice of desktops, with a focus on minimalism.

## Suggested method to access and run the script following installing Arch (using the ISO):

1. Download ```easy-setup.sh``` and save it to a location such as an external hard drive or USB.

2. Boot into the newly installed system, and log in to the terminal using the username and password you created during installation of Arch.

3. Enter the command ```lsblk``` to determiine the /dev entry for the device you saved the script to. For example, the device may show as **/dev/sdb1**.

4. Enter the command ```sudo mkdir -p /mnt/usb``` to create a mountpoint for the device you saved the script to.

5. Mount the device with ```sudo mount **device** /mnt/usb```, then access the device with ```cd /mnt/usb```. Note that if you saved the script into a folder on the device, you will need to cd to that folder - eg if you saved it to a folder called "scripts", then the command would be ```cd /mnt/usb/scripts```.

6. Enter the command ```sh easy-setup.sh``` to run the script. The script uses Whiptail (installed by default with a minimal Arch installation) to provide a simple menu system to make choices for the script. Cursor up/down to the option(s) you want, and press SPACE to select them. The TAB key will let you move between the list of options, and the OK/Cancel buttons. Note that selecting Cancel on a given screen will generally skip all options for that sreen. 

The script will first ask if you want to install some handy BASH shortcuts into ```~/.bashrc```, then if you'd like to activate chaotic-aur and Systemback repos (Systemback is a very useful and powerful tool for backing up your system).

The shortcuts the script adds to ```~/.bashrc``` are as follows (feel free to modify them as you like):

## Default Bash shortcuts installed by the script
| Shortuct | Command Executed | Function |
| --- | --- | --- |
| install | yay -S | Installs packages |
| remove | yay -Rcns | Removes packages, along with unused/orphaned dependencies |
| update | yay -Syu | Performs a system update (the same as ```sudo pacman -syu```, but we're using yay, so AUR pkgs also updated) |
| search | yay -Ss | Search for packages |
| showinst | yay -Qs | Show a list of installed packages matching the argument |
| edit | featherpad | Invoke the Featherpad text editor to edit text files |
| wipe | yay -Scc >/dev/null ; rm -rf ~/.cache/yay ; rm /home/$USER/.bash_history ; clear ; history -c' | Clear terminal, package cache (pacman and AUR) and shell command history |
| updategrub | sudo grub-mkconfig -o /boot/grub/grub.cfg | Perform a Grub menu update |
| reflector | sudo reflector -c AU --save /etc/pacman.d/mirrorlist | Update the pacman reflector list. I suggest you change "AU" to your country code, eg "US" This will ensure packages are downloaded from an Arch mirror in your country. |

By default, the script depends on ```yay``` being installed to run. This is because ```yay``` allows for automated installation of packages from AUR. Therefore, addition of chaotic-aur and yay are essential for all of the software installation segments of the script. If you do not wish to use chaotic-aur and  ```yay```, you can modify the sccript to replace instances of calls to ```yay``` to ```sudo pacman```. However, for the sake of making life a little easier for you, I would recommend allowing the script to install chaotic-aur and yay. Note that the script relies on ```yay``` for installation, including anything that needs to be installed from AUR. If you prefer another AUR helper (such as paru), you are welcome to modify the script to use the tool of your choice. If perchance you really hate ```yay``` (what did it ever do to you?), you are of course free to remove it once the script has completed. I have no intention of modifying the script to do any manual compilation of softawre from AUR etc, without instead using ```yay```. 

Next, the script will ask if you'd like to link certain directories from your $HOME directory to directories in /home/common (and will create these as well if you choose). The benefit here is that data stored in this directory can be retained even if you delete your regular /home/user directory - just use the script to re-link the directories if needed. Please review the script first so you can see which directories it links, and add, remove or modify them as you see fit. The linked directories are modified depending on which browser you choose to install or configure. 

The script will next ask which desktop (if any) you would like to install. Current choices are KDE, Gnome, Cinnamon, Budgie and Cosmic. I may add more desktops in the future. At present I am personally using KDE.

The next few screens will ask you if you wish to install extra software packages, such as web browser, office suite, and several others. You can mark/unmark packages for installation as you like - just cursor up/down and press SPACE to select/deselct items. Note some packages such as Lutris or Wine will have dependencies (eg mesa) that may still be installed, even if you deselect the dependencies here.

<b>(Gnome only) Note:</b> at this point, adding desktop icons for network locations (eg Google Drive) works for the root folder of the network drive. However (on Google Drive at least; I haven't tested other network locations), attempting to link other folders or files from your Google Drive directly onto the desktop does not work. The link and icon will be created on the desktop, but clicking the icon to access the file will not work. If anyone has any idea how to fix this, please let me know! Please note that I am now using KDE and not using Gnome, so I'm not actively monitoring the Gnome section of the script as to whether all extensions install and activate themselves. Since Gnome extensions often have to be updated and rewritten to accommodate new verions of Gnome, it may be that some extensions that used to work before now don't install or work becuase Gnome has been updated. 

Finally, the script clears out all downloaded packages from the cache, and enables some system services, and asks if you'd like to reboot (recommended).

So - here it is. I truly hope some of you find it useful. Good luck. If you find any bugs or otherwise, or have any other comments, please let me know.
