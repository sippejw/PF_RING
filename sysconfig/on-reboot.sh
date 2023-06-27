#!/bin/bash

echo "Setting up hugepages"
if [ ! -d "/mnt/huge" ]; then
    echo "Creating /mnt/huge"
    mkdir -p /mnt/huge || exit_msg "Failed to create /mnt/huge"
fi
grep -s '/mnt/huge' /proc/mounts > /dev/null
if [ $? -ne 0 ] ; then
    echo "Mounting /mnt/huge"
    mount -t hugetlbfs nodev /mnt/huge || exit_msg "Failed to mount /mnt/huge as hugetlbfs"
fi
echo 2048 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
if [ "$?" -ne 0 ]
then
    exit_msg "Failed to set 2048 hugepages!"
fi

echo "Loading kernel module"
cd /opt/PF_RING/kernel
make
make install
insmod pf_ring.ko min_num_slots=65536 enable_tx_capture=0

echo "Loading ZC driver"
cd /opt/PF_RING/drivers/intel/i40e/i40e-2.17.4-zc
make
cd /opt/PF_RING/drivers/intel/i40e/i40e-2.17.4-zc/src
sh load_driver.sh

echo "Build lib"
cd /opt/PF_RING/userland/lib
./configure && make
make install

echo "Build libpcap"
cd /opt/PF_RING/userland/libpcap
./configure && make
make install

echo "Build zbalance"
cd /opt/PF_RING/userland/examples_zc
make zbalance_ipc
