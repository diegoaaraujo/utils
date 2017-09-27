#!/bin/bash

nc_port_is_open() { STATUS="$(nc -vz ${1:?hostname} ${2:?port} 2>&1 > /dev/null)"; }

for line in `cat endpoints`; do
	hostname=$(echo $line | cut -f1 -d,)
	port=$(echo $line | cut -f2 -d,)
	if nc_port_is_open $hostname $port; then
		echo "$hostname:$port - PASS"
	else
		echo "$hostname:$port - FAILED : $STATUS "
	fi
done
