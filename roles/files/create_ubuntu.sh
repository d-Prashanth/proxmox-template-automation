#!/bin/bash
set -e

# Validate input
if [ $# -ne 3 ]; then
    echo "Usage: $0 <VMID> <CODENAME> <TEMPLATE_NAME>"
    exit 1
fi

VMID=$1
CODENAME=$2
TEMPLATE_NAME=$3

STORAGE="local-lvm"
BRIDGE="vmbr0"

IMG_URL="https://cloud-images.ubuntu.com/$CODENAME/current/${CODENAME}-server-cloudimg-amd64.img"
IMG_FILE="/tmp/${CODENAME}-server-cloudimg-amd64.img"

echo "Processing VMID: $VMID"

# Check if VM exists
if qm status $VMID >/dev/null 2>&1; then
    echo "VMID $VMID already exists. Skipping..."
    exit 0
fi

echo "ownloading image..."
wget -q -O $IMG_FILE $IMG_URL

echo "reating VM..."
qm create $VMID --name "$TEMPLATE_NAME" --memory 2048 --cores 2 --net0 virtio,bridge=$BRIDGE

echo "Importing disk..."
qm importdisk $VMID $IMG_FILE $STORAGE

qm set $VMID --scsihw virtio-scsi-pci --scsi0 $STORAGE:vm-${VMID}-disk-0

echo "onfiguring cloud-init..."
qm set $VMID --ide2 $STORAGE:cloudinit
qm set $VMID --boot order=scsi0
qm set $VMID --serial0 socket --vga serial0

echo "Converting to template..."
qm template $VMID

echo "Template $TEMPLATE_NAME created successfully!"
