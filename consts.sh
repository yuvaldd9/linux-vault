# /bin/bash

attach_loop_device()
{
    # Bound the loop file to loop device
    LOOP_DEVICE=$(sudo losetup -f)
    sudo losetup $LOOP_DEVICE $BLOCK_DIR
}

open_vault()
{
    attach_loop_device
    # Decrypt the block encryption for the mounting
    sudo cryptsetup luksOpen $LOOP_DEVICE $DEVICE_NAME
    # Mounting existing device
    sudo mount -t ext4 $DEVICE_MAPPER $GUARD_DIR
    # Decrypt the file system
    sudo fscrypt unlock $ENCRYPTED_FILE_SYSTEM_DIR
}

close_vault()
{
    # Encrypt the filesysyem
    sudo fscrypt lock $ENCRYPTED_FILE_SYSTEM_DIR
    # Unmounting the vault
    sudo umount $GUARD_DIR
    # Encrypt the vault loop device
    sudo cryptsetup close $DEVICE_NAME

    # Deataching loop device
    get_current_loop_device
    sudo losetup -d $LOOP_DEVICE
}

get_current_loop_device()
{
    LOOP_DEVICE=$(losetup -a | grep $BLOCK_DIR | awk '{sub(/:$/,"", $1); print $1}')
}

install_dependencies()
{
    sudo apt update
    sudo apt -y install cryptsetup
    sudo apt -y install fscrypt
}


DEVICE_NAME=guard
DEVICE_MAPPER=/dev/mapper/$DEVICE_NAME

GUARD_DIR=/etc/guard
BLOCK_DIR=/var/guard
ENCRYPTED_FILE_SYSTEM_DIR=$GUARD_DIR/vault
VAULT_FILE_PATH=$ENCRYPTED_FILE_SYSTEM_DIR/vault

# Get current attached loop deivce
get_current_loop_device