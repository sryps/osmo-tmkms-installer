#!/bin/bash
clear

cd $HOME
git clone https://github.com/sryps/osmo-tmkms-installer.git 
 

echo "Installing dependencies..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt install libusb-1.0-0-dev


echo "Allow YubiHSM USB permissions..."
sudo echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="1050", GROUP="yubihsm"' > /etc/udev/rules.d/10-yubihsm.rules
sudo udevadm control --reload-rules && sudo udevadm trigger
groupadd yubihsm
sudo usermod -aG yubihsm $USER
source ~/.profile

cd $HOME
git clone https://github.com/iqlusioninc/tmkms.git && cd tmkms
cargo build --release --features=yubihsm
cargo install tmkms --features=yubihsm


cd $HOME
mkdir yubihsm
tmkms init $HOME/yubihsm
cp $HOME/osmo-tmkms-installer/tmkms.toml $HOME/yubihsm/tmkms.toml







echo "Setup TMKMS service..."
echo "[Unit]
Description=Osmosis TMKMS
After=network.target
[Service]
User=$USER
WorkingDirectory=/home/$USER/.cargo/bin
ExecStart=/home/$USER/.cargo/bin/tmkms start -c /home/$USER/yubihsm/tmkms.toml
Restart=always
RestartSec=3
LimitNOFILE=4096
[Install]
WantedBy=multi-user.target" > tmkms.service

sudo mv tmkms.service /etc/systemd/system/tmkms.service
sudo systemctl enable tmkms
sudo systemctl start tmkms
