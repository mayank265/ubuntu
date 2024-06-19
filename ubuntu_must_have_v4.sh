date >> start_end.txt
sudo apt-get update
sudo apt install -y wget curl 

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/

sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'

sudo apt-get --ignore-missing install -y mysql-server wireshark tcpdump virtualbox-ext-pack virtualbox phpmyadmin
sudo apt-get --ignore-missing install -y build-essential gcc g++ php libapache2-mod-php php-mysql php-curl php-json php-cgi php-curl php-gd php-mbstring php-xml php-xmlrpc 

wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
mkdir ~/anaconda3
bash -b -f -p ~/anaconda3 Anaconda3-2024.02-1-Linux-x86_64.sh

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo apt update

sudo apt install -y ./google-chrome-stable_current_amd64.deb code software-properties-common apt-transport-https microsoft-edge-dev sublime-text

sudo apt-get --ignore-missing install -y copyq  conky-all  geany atril flameshot libarchive-any-perl libfile-basedir-perl libfile-find-rule-perl unrar ncdu make ncdu perl dkms arj artha gimp xclip tree atop bmon cabextract cheese chromium-browser aptitude codeblocks cups-pdf djview dos2unix file-roller filezilla fort77 g++ gcc gdb gdebi geany gftp gimp git-all gnuplot gparted gummi hardinfo htop imagemagick inkscape kile lyx meld mpack nemo nemo-fileroller okular openssh-client openssh-server p7zip-full p7zip-rar default-jdk pidgin rar r-cran-vgam sharutils ssh tree unace unrar unzip uudeview vim vlc xfburn xfig youtube-dl zip net-tools  build-essential libssl-dev libffi-dev cowsay curl feh goo hping3 ifupdown inetutils-traceroute mlocate nmap  wireshark terminator net-tools ndisc6 neovim netdiscover traceroute nmap nodejs npm pacman pip python3-pip python3-pip python3 python3-scapy python3-venv rpm scapy tcpdump traceroute  whois wireshark wireshark-qt  python3-pip build-essential gdb build-essential libssl-dev libffi-dev filezilla fish kitty net-tools openssh-server pacman plank python3-matplotlib sshpass traceroute ettercap-graphical unity-tweak-tool mlocate neovim openvpn screen speedtest-cli traceroute transmission-cli transmission-daemon vsftpd w3m nodejs ca-certificates --fix-missing

sudo snap install pycharm-community --classic
sudo snap install wps-2019-snap
sudo apt-get --ignore-missing install -y texlive-full texstudio

date >> start_end.txt
cat start_end.txt

#####################
# Auxiliary Methods #
#####################
function executeStep () {
BBlue='\033[1;34m'
BYellow='\033[1;33m'
Green='\033[0;32m'
Cyan='\033[0;36m'
Color_Off='\033[0m'
echo -e "${Cyan}STEP: $2"
echo -e "${BYellow}Executing: ${Green} $1 ${Color_Off}"
eval $1
echo -e "${BBlue}Completed: ${Green} $1 ${Color_Off}"
}

######################
# 1. Firewall Config #
######################
# enable ufw firewall and deny incomming traffic to all open ports
executeStep 'ufw enable' 'Enable Firewall'

# check firewall status
executeStep 'ufw status' 'Firewall Status Check'

###########################
# 2. Disable Root Account #
###########################
# disable password for root user
executeStep 'passwd -l root' 'Disable ROOT user password'

#################
# 3. SSH Config #
#################
# install ssh if not installed
executeStep 'apt install openssh-server -y' 'Install OpenSSH Server'

# check ssh status
executeStep 'systemctl status ssh' 'Check SSH Status'

# enable ssh
executeStep 'systemctl enable ssh' 'Enable SSH'

# allow ssh through firewall
executeStep 'ufw allow ssh' 'Allow SSH through Firewall'

# disable ssh root user login
# backup ssh config
executeStep 'cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup' 'Backup SSH Config'

# if PermitRootLogin is commented, uncomment
executeStep 'sed -i "s/#PermitRootLogin/PermitRootLogin/" /etc/ssh/sshd_config' 'Disable ROOT SSH login #1'

# if PermitRootLogin is yes, set it to no
executeStep 'sed -i "s/PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config' 'Disable ROOT SSH login #2'

# restart ssh service
executeStep 'systemctl restart ssh' 'Restart SSH Service'

#############################
# 4. Update Package Manager #
#############################
# run apt update and upgrade
executeStep 'apt update' 'Update APT Repositories'
executeStep 'apt upgrade -y' 'Update Installed Packages'

######################
# 5. Fail2Ban Config #
######################
# install fail2ban
executeStep 'apt install fail2ban -y' 'Install Fail2Ban'

# copy fail2ban config as .local
executeStep 'cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local' 'Backup Fail2Ban Config'

# check fail2ban service and enable it
executeStep 'systemctl status fail2ban.service' 'Check Fail2Ban Service Status'
executeStep 'systemctl enable --now fail2ban.service' 'Enable Fail2Ban Service'

# update fail2ban config
# set ban increment to true
executeStep 'sed -i "s/#bantime.increment/bantime.increment/" /etc/fail2ban/jail.local' 'Enable Fail2Ban Ban-time Increment'

# uncomment ban factor
executeStep 'sed -i "s/#bantime.factor/bantime.factor/" /etc/fail2ban/jail.local' 'Enable Fail2Ban Ban-time Mult Factor'
# set ban factor to 2
executeStep 'sed -i "s/bantime.factor = 1/bantime.factor = 2/" /etc/fail2ban/jail.local' 'Set Mult Factor to 2'

# set ban max retry to 2
executeStep 'sed -i "s/maxretry = 5/maxretry = 2/" /etc/fail2ban/jail.local' 'Set MAX RETRY from 5 to 2'

# restart fail2ban service
executeStep 'systemctl restart fail2ban.service' 'Restart Fail2Ban Service'

# check fail2ban service status
executeStep 'systemctl status fail2ban.service' 'Check Fail2Ban Service Status'

###################
# 6. Final Checks #
###################
# finally check open ports if any
executeStep 'ss -antp' 'Check for Open Ports'

# check firewall status
executeStep 'ufw status' 'Check Firewall Status'

date >> start_end.txt
cat start_end.txt
