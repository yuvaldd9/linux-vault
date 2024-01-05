#!/bin/bash

source guard_scripts/consts.sh

GUARD_SCRIPTS_DIR=/bin/guard_scripts

# Install dependencies
install_dependencies

# Create guard user
create_guard_user

sudo mkdir -p $GUARD_SCRIPTS_DIR
sudo cp guard_scripts/* $GUARD_SCRIPTS_DIR

sudo chown -R guard:guard $GUARD_SCRIPTS_DIR
sudo chmod -R u+s $GUARD_SCRIPTS_DIR

sudo cp password_guard /bin/

sudo chown -R guard:guard /bin/password_guard
sudo chmod -R u+s /bin/password_guard

source $GUARD_SCRIPTS_DIR/initiate_system.sh