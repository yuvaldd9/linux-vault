# /bin/sh

GUARD_DIR=/etc/guard

sudo apt update
sudo apt -y install cryptsetup
sudo apt -y install fscrypt

# Creation of the guard user
sudo useradd guard

# Create the vault - Loop file
dd if=/dev/zero of=vault bs=1024 count=512000

# Bound the loop file to loop device
LOOP_DEVICE=$(sudo losetup -f)
sudo losetup $LOOP_DEVICE vault

# Setup the block encryption for the loop file
cryptsetup luksFormat $LOOP_DEVICE
sudo cryptsetup luksFormat $LOOP_DEVICE
sudo cryptsetup luksOpen $LOOP_DEVICE guard

# Set up the loop device file-system and
# enabling encryption of the file-esystem
sudo mkfs -t ext4 -v /dev/mapper/guard
sudo tune2fs -O encrypt /dev/mapper/guard

# Mounting the loop device
mkdir -p $GUARD_DIR
sudo mount -t ext4 /dev/mapper/guard $GUARD_DIR

# Enable File-system encryption
sudo fscrypt setup
sudo mkdir -p $GUARD_DIR/vault
sudo fscrypt setup $GUARD_DIR
sudo fscrypt encrypt $GUARD_DIR/vault

sudo chown -R guard:guard $GUARD_DIR
