# /bin/bash

source consts.sh

# Creation of the guard user
if [ ! id "guard" &> /dev/null ]; then
    sudo useradd guard
    echo "Created guard user"
else
    echo "guard user was created"
fi

# Create the vault if not exists - Loop file
if [ ! -f "$BLOCK_DIR" ]; then
    sudo dd if=/dev/zero of=$BLOCK_DIR bs=1024 count=512000
    SYSTEM_INITIATED=0
else
    SYSTEM_INITIATED=1
fi

attach_loop_device

# Setup the vault device if it has not been set.
# If it has been set so just mounting the device
if [ "$SYSTEM_INITIATED" -eq 0 ]; then
    # Setup the block encryption for the loop file
    sudo cryptsetup -q luksFormat $LOOP_DEVICE
    sudo cryptsetup luksOpen $LOOP_DEVICE $DEVICE_NAME

    # Set up the loop device file-system and
    # enabling encryption of the file-esystem
    sudo mkfs.ext4 -v $DEVICE_MAPPER
    sudo tune2fs -O encrypt $DEVICE_MAPPER

    # Mounting the loop device
    sudo mkdir -p $GUARD_DIR
    sudo mount -t ext4 $DEVICE_MAPPER $GUARD_DIR

    # Enable File-system encryption
    sudo fscrypt setup
    sudo mkdir -p $ENCRYPTED_FILE_SYSTEM_DIR
    sudo fscrypt --quiet setup $GUARD_DIR
    sudo fscrypt --quiet encrypt $ENCRYPTED_FILE_SYSTEM_DIR

    # Generate the vault file
    sudo echo "{}" > $VAULT_FILE_PATH

    close_vault

    # File permissions
    sudo chown -R guard:guard $GUARD_DIR
    sudo chown -R guard:guard $BLOCK_DIR
fi