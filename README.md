# Install all my packages in Manjaro after get new Computer
There is no reason for reinstall Manjaro. The only reason is to get a new system.

### Activate AUR in pamac
https://forum.manjaro.org/t/enable-aur-using-command-line/79107/2

```
sudo sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf
```


## Get self installed packages
https://www.reddit.com/r/ManjaroLinux/comments/fzog8g/get_a_list_of_packages_you_installed_yourself/


### Save self installed packages
pacman -Qqe get all installed packages. In ```/desktopfs-pkgs.txt``` there are packages which Manjaro would install by upgrade.
grep -v filters all packages which are not in both list. So you get only the self installed packages.

```
pacman -Qqe | grep -v "$(awk '{print $1}' /desktopfs-pkgs.txt)" > ./programs.txt  
```

## Install Packages from list
```
pamac install $(cat ./programs.txt) 
```