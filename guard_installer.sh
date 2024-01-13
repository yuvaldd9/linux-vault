#!/bin/bash

source guard_scripts/consts.sh

GUARD_SCRIPTS_DIR=/bin/guard_scripts

# Install dependencies
install_dependencies

# Install the files
sudo mkdir -p $GUARD_SCRIPTS_DIR
sudo cp guard_scripts/* $GUARD_SCRIPTS_DIR

sudo chown -R root:root $GUARD_SCRIPTS_DIR
sudo chmod -R u+s $GUARD_SCRIPTS_DIR

sudo cp password_guard /bin/

sudo chown -R root:root /bin/password_guard
sudo chmod -R u+s /bin/password_guard

source $GUARD_SCRIPTS_DIR/initiate_system.sh