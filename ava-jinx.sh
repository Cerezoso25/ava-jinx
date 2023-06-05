#!/bin/bash

# Get the latest version number
version=$(curl -s https://api.github.com/repos/Ryujinx/release-channel-master/releases/latest | grep 'tag_name' | cut -d\" -f4)

echo "Latest version is: $version"

# download and extract the latest version
echo "Downloading Ryujinx Ava..."
curl -L "https://github.com/Ryujinx/release-channel-master/releases/download/${version}/test-ava-ryujinx-${version}-linux_x64.tar.gz" > test-ava-ryujinx-${version}-linux_x64.tar.gz

# extract the tarball to /home/${USER}/.local/share/Ryujinx-Ava
echo "Installing Ryujinx Ava..."
mkdir -p /home/${USER}/.local/share/Ryujinx-Ava
tar -xf test-ava-ryujinx-${version}-linux_x64.tar.gz -C /home/${USER}/.local/share/Ryujinx-Ava

# Move files from publish directory to Ryujinx-Ava directory
mv /home/${USER}/.local/share/Ryujinx-Ava/publish/* /home/${USER}/.local/share/Ryujinx-Ava/
rmdir /home/${USER}/.local/share/Ryujinx-Ava/publish

# download the icon
echo "Downloading Icon..."
mkdir -p /home/${USER}/.local/share/icons
curl -L "https://raw.githubusercontent.com/Cerezoso25/ava-jinx/4497a5d290a0879c5e3a4786f65e6a8591054f71/Ryujinx.png" > /home/${USER}/.local/share/icons/Ryujinx.png

# remove the downloaded tarball
rm test-ava-ryujinx-${version}-linux_x64.tar.gz

# Create a .desktop file
echo "Creating .desktop file..."
mkdir -p /home/${USER}/.local/share/applications
echo '[Desktop Entry]
Version=1.0
Type=Application
Name=Ryujinx-Ava
GenericName=Nintendo Switch Emulator
Comment=Nintendo Switch video game console emulator
Icon=/home/'${USER}'/.local/share/icons/Ryujinx.png
TryExec=/home/'${USER}'/.local/share/Ryujinx-Ava/Ryujinx.sh
Exec=env COMPlus_EnableAlternateStackCheck=1 GDK_BACKEND=x11 /home/'${USER}'/.local/share/Ryujinx-Ava/Ryujinx.sh %f
Categories=Game;Emulator;GTK;
MimeType=application/x-nx-nro;application/x-nx-nso;application/x-nx-nsp;application/x-nx-xci;
Keywords=Switch;Nintendo;
Terminal=true
StartupWMClass=Ryujinx
PrefersNonDefaultGPU=true' | tee /home/${USER}/.local/share/applications/ryujinx-ava.desktop

echo "Installation done."
