#!/usr/bin/env bash

export VAGRANT_CLOUD_ACCOUNT=XXX
echo ${VAGRANT_CLOUD_ACCOUNT}

SLEEP=${1:-1}
echo "Sleeping for ${SLEEP} seconds..."
sleep ${SLEEP} 

export PACKER_LOG=activate
export PACKER_LOG_PATH=packer-log.txt

# use this a the version tag
UNIXTIME=$(date +%s)

PACKER_FILE=${2:-packer.json}

VALIDATE="packer validate ${PACKER_FILE}"
echo ${VALIDATE}
${VALIDATE}

# build only VirtualBox
packer build --force --only virtualbox-ovf ${PACKER_FILE}
vagrant box add --clean --force --name bionic-xubuntu --provider virtualbox vagrant/xubuntu-bionic-virtualbox.box

vagrant box list
ls -alh vagrant
