#!/bin/bash

# run zbalance

#. config
. /opt/PF_RING/sysconfig/zbalance.conf


# TD_IFACE could be a CSV list of interfaces.
# Pull them apart to ensure each gets zc: prefix
ifcarg=""
IFS=',' read -r -a ifcarray <<< "${ZB_IFACE}"
didfirst=0
for ifc in "${ifcarray[@]}"
do
    ifcelem="zc:${ifc}"
    if [[ $ifc = "zc:"* ]]; then
	ifcelem=${ifc}
    fi
    if [ $didfirst -ne 0 ]; then
	ifcarg="$ifcarg,$ifcelem"
    else
	ifcarg=$ifcelem
	didfirst=1
    fi
done

# PF_Ring should be installed and zbalance_ipc should be available in your path
if ! command -v /opt/PF_RING/userland/examples_zc/zbalance_ipc &> /dev/null
then
    echo "zbalance_ipc could not be found,"
    echo "please ensure pf_ring is instaled and zbalance_ipc is in you PATH."
    echo "Installing from package automtically installs executable scripts"
    echo "see https://www.ntop.org/guides/pf_ring/get_started/packages_installation.html"
    exit
fi


sudo /opt/PF_RING/userland/examples_zc/zbalance_ipc -i $ifcarg -c ${ZB_CLUSTER_ID} -n ${ZB_CORECOUNT} -m ${ZBALANCE_HASH_MODE} -g ${ZBALANCE_CORE}
