#!/bin/bash

sudo sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf

pamac install $(cat ./programs.txt) 

mkdir /home/$(logname)/.bash_contents
chown -R $(logname):$(logname) /home/$(logname)/.bash_contents
echo -e "alias ll=\"ls -lah\"" >>  /home/$(logname)/.bash_contents/aliases

mkdir /home/$(logname)/DevelopTools
chown $(logname):$(logname)
cd /home/$(logname)/DevelopTools
git clone https://github.com/flutter/flutter.git -b stable
chown -R $(logname):$(logname) /home/$(logname)/DevelopTools

echo -e "\n# Own aliases\n" >> /home/$(logname)/.zshrc
echo -e "source /home/$(logname)/.bash_contents/aliases\n" >> /home/$(logname)/.zshrc

echo -e "# PATH\n" >> /home/$(logname)/.zshrc
echo -e "export CHROME_EXECUTABLE=\"/opt/google/chrome/chrome\"" >> /home/$(logname)/.zshrc
echo -e "export PATH=\"\$PATH:/home/$(logname)/DevelopTools/flutter/bin\"" >> /home/$(logname)/.zshrc

