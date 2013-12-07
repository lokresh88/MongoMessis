#!/bin/bash
flstr="Base"

loadfilename="RunConfigs/$flstr.dat"

mkdir -p $flstr
conn=1
tgt=100
if [ $# -gt 0 ]; then
	tgt=$1
	conn=$3
else
	echo "USAGE: "
	echo "$0 <target-ops-per-sec> <total-fields> <number-of-connections>"
	exit
fi

echo "Dropping the database"
../MongoEval/Mongo/mongodb-linux-x86_64-1.8.3/bin/mongo ycsb dropmongo.js
sleep 2

echo "Loading fresh data"
./bin/ycsb load mongodb -s -P workloads/workloada -P $loadfilename -target 10000000

#Loop on all workloads 
for w in "a" "b" "c" "d" "f"
do
	rm -f $flstr/__pid
	#Invoke ycsb instance for every connection
	for (( c=1; c<=$conn; c++))
	do
		echo "Launching ycsb for connection:#$c"
		./bin/ycsb run mongodb -s -P workloads/workload$w -P $loadfilename -target $tgt -p fieldcount=$2 > $flstr/"wl$w-$c.txt" &
		echo "$!" >> $flstr/__pid
	done

	while read line
	do 
		wait $line
	done < $flstr/__pid

	echo "Experiments on all the connections complete. Collecting statistics. "
	sum_readLat=0
	sum_updLat=0
	sum_insLat=0
	sum_rmwLat=0
	ifread=0
	ifrmw=0
	ifupd=0
	ifinsert=0
	avgReadLat=0
	avgUpdLat=0
	avgInsLat=0
	avgRmwLat=0
	throuput=0
	for (( c=1; c<=$conn; c++))
	do
		ifread=`grep readproportion workloads/workload$w | cut -d"=" -f2 2>/dev/null`
		ifrmw=`grep readmodifywriteproportion workloads/workload$w | cut -d"=" -f2 2>/dev/null`
		throuput=`grep "Throughput" $flstr/"wl$w-$c.txt" | cut -d"," -f3 2>/dev/null`
		if [ "$ifread" != "0" -o "$ifrmw" != "0" ]; then
			readLat=`grep "AverageLatency" $flstr/"wl$w-$c.txt" | grep "READ]" | cut -d"," -f3 2>/dev/null`
			sum_readLat=$(echo "scale=9; $sum_readLat + $readLat" | bc 2>/dev/null)
		fi
		ifupd=`grep updateproportion workloads/workload$w | cut -d"=" -f2 2>/dev/null`
		if [ "$ifupd" != "0" -o "$ifrmw" != "0" ]; then
			updLat=`grep "AverageLatency" $flstr/"wl$w-$c.txt" | grep "UPDATE" | cut -d"," -f3 2>/dev/null`
			echo "updLat:$updLat"
			sum_updLat=$(echo "scale=9; $sum_updLat + $updLat" | bc 2>/dev/null)
		fi
		ifinsert=`grep insertproportion workloads/workload$w | cut -d"=" -f2 2>/dev/null`
		echo "ifinsert:$ifinsert"
		if [ "$ifinsert" != "0" ]; then
			insLat=`grep "AverageLatency" $flstr/"wl$w-$c.txt" | grep "INSERT" | cut -d"," -f3 2>/dev/null`
			echo "insLat:$insLat"
			sum_insLat=$(echo "scale=9; $sum_insLat + $insLat" | bc 2>/dev/null)
		fi
		if [ "$ifrmw" != "0" ]; then
			rmwLat=`grep "AverageLatency" $flstr/"wl$w-$c.txt" | grep "READ-MODIFY-WRITE" | cut -d"," -f3 2>/dev/null`
			sum_rmwLat=$(echo "scale=9; $sum_rmwLat + $rmwLat" | bc 2>/dev/null)
		fi
	done
	
	echo "Calculating the average latencies"
	if [ "$ifread" != "0" -o "$ifrmw" != "0" ]; then
		avgReadLat=$(echo "scale=9; $sum_readLat / $conn" | bc 2>/dev/null)
	fi
	if [ "$ifupd" != "0" -o "$ifrmw" != "0" ]; then
		avgUpdLat=$(echo "scale=9; $sum_updLat / $conn" | bc 2>/dev/null)
	fi
	if [ "$ifinsert" != "0" ]; then
		avgInsLat=$(echo "scale=9; $sum_insLat / $conn" | bc 2>/dev/null)
	fi
	if [ "$ifrmw" != "0" ]; then
		avgRmwLat=$(echo "scale=9; $sum_rmwLat / $conn" | bc 2>/dev/null)
	fi
	echo "Saving the performance results into $flstr/consol/wl$w_consol.txt"
	echo "$tgt,$avgReadLat,$avgUpdLat,$avgInsLat,$avgRmwLat,$throuput,$2,conn-$3" >> $flstr/consol/wl"$w"_consol.txt

done



