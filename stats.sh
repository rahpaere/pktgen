#! /bin/sh

gather () {
	ta=$tb
	pa=$pb
	tb=`date +%s.%N`
	pb=`cat /sys/class/net/eth1/statistics/rx_packets`
}

report () {
	echo "scale=9; ($pb - $pa) / ($tb - $ta)" | bc
}

gather
while true
do
	sleep 10
	gather
	report
done
