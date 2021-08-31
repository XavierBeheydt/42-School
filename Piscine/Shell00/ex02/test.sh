#!/bin/bash

export LC_ALL=C

check_entry() {
	name=$1
	expected_perms=$2
	expected_size=$3
	expected_month=$4
	expected_day=$5
	expected_time=$6

	echo "-= $name =-"
	info=$(ls -ld "$name" | awk '{print $1, $5, $6, $7, $8}')
	perms=$(echo "$info" | awk '{print $1}')
	size=$(echo "$info" | awk '{print $2}')
	month=$(echo "$info" | awk '{print $3}')
	day=$(echo "$info" | awk '{print $4}')
	time=$(echo "$info" | awk '{print $5}')

	[ "$perms" == "$expected_perms" ] && echo "✅ $name permissions OK ($perms)" || echo "❌ $name permissions KO ($perms, expected $expected_perms)"
	if [ -n "$expected_size" ]; then
		[ "$size" == "$expected_size" ] && echo "✅ $name size OK ($size)" || echo "❌ $name size KO ($size, expected $expected_size)"
	fi
	[ "$month" == "$expected_month" ] && echo "✅ $name month OK ($month)" || echo "❌ $name month KO ($month, expected $expected_month)"
	[ "$day" == "$expected_day" ] && echo "✅ $name day OK ($day)" || echo "❌ $name day KO ($day, expected $expected_day)"
	[ "$time" == "$expected_time" ] && echo "✅ $name hour:minute OK ($time)" || echo "❌ $name hour:minute KO ($time, expected $expected_time)"
}

rm -rf exo2.tar
rm -rf test[0-9]*

mkdir -p test0 && chmod 715 test0 && touch -t 06012047 test0
check_entry test0 "drwx--xr-x" "" "Jun" "1" "20:47"

printf "1234" > test1 && chmod 714 test1 && touch -t 06012146 test1
check_entry test1 "-rwx--xr--" "4" "Jun" "1" "21:46"

mkdir test2 && chmod 504 test2 && touch -t 06012245 test2
check_entry test2 "dr-x---r--" ""  "Jun" "1" "22:45"

printf 'a' > test3 && touch -t 06012344 test3 && chmod 404 test3
check_entry test3 "-r-----r--" "1" "Jun" "1" "23:44"

printf "12" > test4 && chmod 641 test4 && touch -t 06012343 test4
check_entry test4 "-rw-r----x" "2" "Jun" "1" "23:43"

printf "1" > test5 && chmod 404 test5 && touch -t 06012344 test5
check_entry test5 "-r-----r--" "1" "Jun" "1" "23:44"

ln -s test0 test6 && touch -ht 06012220 test6
check_entry test6 "lrwxrwxrwx" "5" "Jun" "1" "22:20"

tar -cf exo2.tar test[0-9]*
tar -tf exo2.tar
rm -rf test[0-9]*
