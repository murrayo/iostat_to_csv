#!/bin/sh

# Usage example: ./iostat_to_csv.sh -f "iostat001.txt" -d "nvme0n1 sda" -p "example"

usage() { echo "Usage: $0 [-f <iostat_filename>] [-d <'disk list'>] [-p output_prefix]" 1>&2; exit 1; }


while getopts ":hf:d:p:" arg
do	case "$arg" in
    h) 
        usage
        ;;
    f)
        filename="${OPTARG}"
        ;;
    d)  intreasting_disks="${OPTARG}"
        ;;
    p)
        output_prefix="${OPTARG}"
        ;;
    :)
        printf "missing argument for -%s\n" "$OPTARG" >&2; usage
        ;;
    \?)
        printf "illegal option: -%s\n" "$OPTARG" >&2; usage
        ;;
    esac
done

# mandatory arguments
if [ ! "$filename" ] || [ ! "$intreasting_disks" ] || [ ! "$output_prefix" ]; then
    echo "argument missing"
    usage
fi

# Finally run two lines of code!

for i in $intreasting_disks
do
    echo "Time,rs,ws,rkBs,wkBs,r_await,w_await" > ${output_prefix}_iostat_${i}.csv
    awk '/avg-cpu/{if (a && a !~ /avg-cpu/) printf substr(a,10,8)","} {a=$0} /'"${i}"'/{print $2","$8","$3","$9","$6","$12}' ${filename} >>${output_prefix}_iostat_${i}.csv
done

# What just happened
current_folder=`pwd`
echo "Output file: \"${current_folder}/${output_prefix}_iostat_${i}.csv\""

    # file types
    
    # 001)
		
	# Linux 5.4.156-83.273.amzn2.x86_64 (iris-0-0) 	01/08/22 	_x86_64_	(8 CPU)
	# 01/08/22 18:06:04
	# avg-cpu:  %user   %nice %system %iowait  %steal   %idle
	#            0.71    0.00    0.36    0.10    0.00   98.83
	
	#                   2       3           4     5     6       7           8       9       10      11      12      13        14        15     16       17      18     19       20     21
	# Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wkB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dkB/s   drqm/s  %drqm d_await dareq-sz  aqu-sz  %util
	# nvme0n1          0.47     12.55     0.00   0.01    1.62    26.70    7.24    391.06     1.25  14.71    2.22    53.98    0.00      0.00     0.00   0.00    0.00     0.00    0.01   0.90
	# sda              0.22     15.82     0.00   0.04    1.94    71.97    2.92    253.18     2.27  43.73    4.17    86.74    0.00      0.00     0.00   0.00    0.00     0.00    0.01   0.71
	# 01/08/22 18:06:05
	# avg-cpu:  %user   %nice %system %iowait  %steal   %idle
	#            4.39    0.00    3.14    0.13    0.00   92.35
	# Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wkB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dkB/s   drqm/s  %drqm d_await dareq-sz  aqu-sz  %util
	# nvme0n1          2.00      8.00     0.00   0.00    0.50     4.00   48.00    372.00     0.00   0.00    0.58     7.75    0.00      0.00     0.00   0.00    0.00     0.00    0.00   6.80
	# sda              0.00      0.00     0.00   0.00    0.00     0.00    2.00     48.00    10.00  83.33    3.00    24.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00   0.80
	# 01/08/22 18:06:06
	# avg-cpu:  %user   %nice %system %iowait  %steal   %idle
	#           57.60    0.00    8.68    5.36    0.00   28.35
	# Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wkB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dkB/s   drqm/s  %drqm d_await dareq-sz  aqu-sz  %util
	# nvme0n1          5.00     40.00     0.00   0.00    0.60     8.00  642.00  16516.50    76.00  10.58    0.78    25.73    0.00      0.00     0.00   0.00    0.00     0.00    0.01  93.20
	# sda              9.00    188.00     0.00   0.00    1.56    20.89  337.00  15084.00   410.00  54.89    2.69    44.76    0.00      0.00     0.00   0.00    0.00     0.00    0.10  94.40
	
	


