#!/bin/sh
#
# Send 60-byte packets at maximum rate through eth1 to 10.0.0.2.
# Additional arguments are passed on to configure the device under pktgen;
# try "pkt_size BYTES" or "rate US" or "ratep PPS".
#

modprobe pktgen

pgset () {
	echo "$*"
	echo "$*" > $PGDEV
	cat $PGDEV | fgrep Result:
}

PGDEV=/proc/net/pktgen/kpktgend_0
pgset rem_device_all 
pgset add_device eth1 
pgset max_before_softirq 10000

PGDEV=/proc/net/pktgen/eth1
pgset clone_skb 0 
pgset pkt_size 60 
pgset dst 10.0.0.2 
pgset count 0
for param
do
	pgset $param
done

PGDEV=/proc/net/pktgen/pgctrl
pgset start 
