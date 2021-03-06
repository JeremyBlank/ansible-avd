#!/bin/bash

# Local Installation Path
_ROOT_INSTALLATION_DIR="${PWD}/arista-ansible"

# List of Arista Repositories
_REPO_AVD="https://github.com/aristanetworks/ansible-avd.git"
_REPO_CVP="https://github.com/aristanetworks/ansible-cvp.git"
_REPO_EXAMPLES="https://github.com/aristanetworks/ansible-avd.git"

# Path for local repositories
_LOCAL_AVD="${_ROOT_INSTALLATION_DIR}/ansible-avd"
_LOCAL_CVP="${_ROOT_INSTALLATION_DIR}/ansible-cvp"
_LOCAL_EXAMPLES="${_ROOT_INSTALLATION_DIR}/netdevops-examples"

# Folder where Dockerfile and Makefile are located
_DEV_FOLDER="${_LOCAL_AVD}/development/"

echo "Arista Ansible installation is starting"

# Test if git is installed
if hash git 2>/dev/null; then
    echo "  * git has been found here: " $(which git)
else
    echo "  ! git is not installed, installation aborted"
    exit 1
fi

if [ ! -d "${_ROOT_INSTALLATION_DIR}" ]; then 
    echo "  * creating local installation folder: ${_ROOT_INSTALLATION_DIR}"
    mkdir -p ${_ROOT_INSTALLATION_DIR}
    echo "  * cloning ansible-avd collections to ${_LOCAL_AVD}"
    git clone ${_REPO_AVD} ${_LOCAL_AVD}
    echo "  * cloning ansible-cvp collections to ${_LOCAL_CVP}"
    git clone ${_REPO_CVP} ${_LOCAL_CVP}
    echo "  * cloning netdevops-examples collections to ${_LOCAL_EXAMPLES}"
    git clone ${_REPO_EXAMPLES} ${_LOCAL_EXAMPLES}
    if [ -d ${_DEV_FOLDER} ]; then
        echo "deploying development content to ${_ROOT_INSTALLATION_DIR}"
        cp ${_DEV_FOLDER}/* ${_ROOT_INSTALLATION_DIR}
    else
        echo "  ! error: development folder is missing"
    fi
else
    echo "  ! local installation folder already exists - ${_ROOT_INSTALLATION_DIR}"
fi
