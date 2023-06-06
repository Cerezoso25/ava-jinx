#!/bin/bash

echo "What would you like to do?"
echo "1) Install Ryujinx Ava"
echo "2) Uninstall Ryujinx Ava"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
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
        curl -s -L "https://raw.githubusercontent.com/Cerezoso25/ava-jinx/main/Ryujinx.png" > /home/${USER}/.local/share/icons/Ryujinx.png

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
        Exec=/home/'${USER}'/.local/share/Ryujinx-Ava/Ryujinx.sh %f
        Categories=Game;Emulator;
        MimeType=application/x-nx-nro;application/x-nx-nso;application/x-nx-nsp;application/x-nx-xci;
        Keywords=Switch;Nintendo;
        Terminal=true
        StartupWMClass=Ryujinx
        PrefersNonDefaultGPU=true' | tee /home/${USER}/.local/share/applications/ryujinx-ava.desktop

        echo "Installation done."
        ;;
    2)
        echo "Uninstalling Ryujinx Ava..."

        # Remove Ryujinx Ava files
        rm -rf /home/${USER}/.local/share/Ryujinx-Ava/

        # Remove Icon
        rm /home/${USER}/.local/share/icons/Ryujinx.png

        # Remove .desktop file
        rm /home/${USER}/.local/share/applications/ryujinx-ava.desktop

        echo "Uninstallation done."
        ;;
    *)
        echo "Invalid choice. Please enter 1 for install or 2 for uninstall."
        exit 1
        ;;
esac
