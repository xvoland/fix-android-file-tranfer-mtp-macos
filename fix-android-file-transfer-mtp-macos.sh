#!/bin/sh

read -p "Are you sure to remove Samsung drivers? " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Please, close Smart Switch and/or SideSync, Kext. And unplug your phone from USB."
    echo "Press any key to continue..."
    read

    echo
    echo "Current driver:"
    kextstat | grep -v com.apple

    echo "Trying to remove drivers..."
    sudo kextunload -b com.devguru.driver.SamsungComposite -v 5        # disable Samsung four drivers
    sudo kextunload -b com.devguru.driver.SamsungACMData -v 5
    sudo kextunload -b com.devguru.driver.SamsungMTP -v 5
    sudo kextunload -b com.devguru.driver.SamsungACMControl -v 5
    sudo kextunload -b /System/Library/Extentions/ssuddrv.kext -v 5    # disable ssuddrv and all that it contains

    sudo rm -rf /System/Library/Extentions/ssuddrv.kext

    return 1
fi

IFS=$SAVEIFS