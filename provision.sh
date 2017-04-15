#!/usr/bin/env bash

# Install the default ubuntu desktop
#sudo apt-get -y update
#sudo apt-get -y upgrade
#sudo apt install -y ubuntu-desktop
# 05abr17 Joao .. problem identified on apt-get update/upgrade. It did not work because it could not force the automatic answers to questions.
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::options::="--force-confdef" -o Dpkg::options::="--force-confold" update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::options::="--force-confdef" -o Dpkg::options::="--force-confold" dist-upgrade

# Set values to environment variables
sudo echo "LANG=en_US.UTF-8" >> /etc/environment
sudo echo "LANGUAGE=en_US.UTF-8" >> /etc/environment
sudo echo "LC_ALL=en_US.UTF-8" >> /etc/environment
sudo echo "LC_CTYPE=en_US.UTF-8" >> /etc/environment
sudo echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment

# Configure the keyboard to br
sudo chmod +u+w /etc/default/keyboard
sudo echo 'XKBMODEL="pc105"' > /etc/default/keyboard
sudo echo 'XKBLAYOUT="br"' >> /etc/default/keyboard
sudo echo 'XKBVARIANT=""' >> /etc/default/keyboard
sudo echo 'XKBOPTIONS=""' >> /etc/default/keyboard

# Configure the Timezone to America/Sao_Paulo
sudo echo 'America/Sao_Paulo' > /etc/timezone
sudo echo 'export TZ=America/Sao_Paulo' >> /home/vagrant/.bashrc

# Tomcat
sudo wget http://ftp.unicamp.br/pub/apache/tomcat/tomcat-8/v8.5.13/bin/apache-tomcat-8.5.13.tar.gz -O /opt/apache-tomcat-8.5.13.tar.gz
cd /opt
sudo tar -zxvf /opt/apache-tomcat-8.5.13.tar.gz
sudo chown -R 777 /opt/apache-tomcat-8.5.13
sudo rm -rf /opt/apache-tomcat-8.5.13.tar.gz

# Maven settings and dependencies
sudo curl http://cjsistemas.com.br/transf/repository.tar.gz -o /home/vagrant/.m2
cd /home/vagrant/.m2
sudo chmod 777 ./*
sudo tar -zxvf repository.tar.gz
sudo rm -f /home/vagrant/.m2/repository.tar.gz

# Sets values to environment variables in .bashrc for Eclipse to work.
sudo echo 'export path="/usr/lib/jvm/java-8-openjdk-amd64/bin/java:$path"' >> /home/vagrant/.bashrc
sudo echo 'export PS1="\w\$ "' >> /home/vagrant/.bashrc

# Eclipse Neon and plugins
#sudo wget -O /opt/eclipseneon64.tar.gz http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-linux-gtk-x86_64.tar.gz
sudo wget -O /opt/eclipseneon64.tar.gz http://cjsistemas.com.br/transf/eclipseneon.tar.gz
cd /opt/ && sudo tar -zxvf eclipseneon64.tar.gz
sudo rm -f /opt/eclipseneon64.tar.gz
sudo chown -R 777 /opt/eclipse

# Creates shortcut to Eclipse Neon on desktop
sudo echo '[Desktop Entry]' > /usr/share/applications/eclipse.desktop
sudo echo 'Type=Development' >> /usr/share/applications/eclipse.desktop
sudo echo 'Terminal=false' >> /usr/share/applications/eclipse.desktop
sudo echo 'Icon=/opt/eclipse/icon.xpm' >> /usr/share/applications/eclipse.desktop
sudo echo 'Name=Eclipse' >> /usr/share/applications/eclipse.desktop
sudo echo 'Exec=/opt/eclipse/eclipse' >> /usr/share/applications/eclipse.desktop
sudo echo 'Type=Application' >> /usr/share/applications/eclipse.desktop
sudo echo 'Categories=Development;Utility;' >> /usr/share/applications/eclipse.desktop
sudo cp /usr/share/applications/eclipse.desktop /home/vagrant/Desktop

# Clones the repository
cd /home/vagrant/workspace
sudo git clone https://github.com/cjucasfs/cliven.git --recursive
sudo chown -R vagrant ./*

# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
#sudo apt -y update
#sudo apt -f -y install
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::options::="--force-confdef" -o Dpkg::options::="--force-confold" update
sudo DEBIAN_FRONTEND=noninteractive apt-get -f -y -o Dpkg::options::="--force-confdef" -o Dpkg::options::="--force-confold" install
sudo apt install -y libindicator7 libappindicator1
sudo apt install -y google-chrome-stable

# Installing Ubuntu desktop
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::options::="--force-confdef" -o Dpkg::options::="--force-confold" ubuntu-desktop

sudo shutdown -r now
