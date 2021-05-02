date >> start_end.txt 
sudo apt-get update
sudo apt-get --ignore-missing install -y curl
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg

sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list


sudo apt update
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/

sudo apt install -y ./google-chrome-stable_current_amd64.deb code software-properties-common apt-transport-https wget microsoft-edge-dev sublime-text
#sudo apt install -y  
sudo snap install pycharm-community --classic

mkdir ~/anaconda3 
bash -b -f -p ~/anaconda3 Anaconda3-2020.02-Linux-x86_64.sh

sudo apt-get --ignore-missing install -y build-essential gcc g++ make perl dkms arj artha gimp xclip tree atop bmon cabextract cheese chromium-browser aptitude codeblocks cups-pdf djview dos2unix file-roller filezilla fort77 g++ gcc gdb gdebi geany gftp gimp git-all gnuplot gparted gummi hardinfo htop imagemagick inkscape kile lyx meld mpack nemo nemo-fileroller okular openssh-client openssh-server p7zip-full p7zip-rar pdfshuffler default-jdk pidgin rar r-cran-vgam sharutils ssh texlive-full texstudio tree unace unrar unzip uudeview vim vlc xfburn xfig youtube-dl zip --fix-missing

date >> start_end.txt
cat start_end.txt  
