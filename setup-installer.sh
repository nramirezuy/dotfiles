#!/bin/sh -e

# Requirements
command -v lftp > /dev/null 2>&1 || { echo >&2 "lftp is required"; exit 1; }

# Ask user an unmounted drive and that exists
DRIVE=''
while grep -o "$DRIVE" /proc/mounts > /dev/null || ! ls $DRIVE > /dev/null; do
  lsblk
  read -p "Select an unmounted device to setup the installer: " DRIVE
done

ISO_FILE=$(realpath $1)

if [ -z $ISO_FILE ]; then
  # Download Arch downloads web page to temp file
  ARCH_DOWNLOAD_PAGE=$(mktemp)
  curl -s --fail --show-error 'https://www.archlinux.org/download/' > $ARCH_DOWNLOAD_PAGE

  # Verify we are getting contents
  if awk '{if(NR<1000){exit 1;}}' $ARCH_DOWNLOAD_PAGE ; then
    echo >&2 "Download page number of lines too low"
    exit 1
  fi

  # Extract the magnet link from the web page
  MAGNET=$(grep -Po "\K(magnet:[^\"]+)" $ARCH_DOWNLOAD_PAGE | sed 's/\&amp;/\&/g')

  # Download magnet link
  lftp --norc -c "set torrent:seed-max-time .1; torrent $(echo $MAGNET | sed 's/\&/\\\&/g')"
  killall -9 lftp

  # Extract path to iso file
  ISO_FILE=i$(realpath $(echo $MAGNET | grep -Po "dn=\K([^&]+)"))
fi

# WARNING: POWERFUL STUFF
# Generate the installer drive with disk destroyer
echo "WARNING: DISK DESTROYER already started, too late to go back :("
echo "Destroying $DRIVE with $ISO_FILE"
su -c 'dd if='$ISO_FILE' of='$DRIVE' status="progress"' - root
