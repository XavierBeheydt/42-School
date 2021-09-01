#!/bin/bash

mkdir -p subfolder subfolder.sh
touch file{1,2,3}.sh subfolder/file{4,5,6}.sh subfolder.sh/file{7,8,9,10.sh,11.sh}

result=$(bash find_sh.sh)
expected_result="find_sh
test
file4
file5
file6
file10
file11
file1
file2
file3"

[ "$(echo "$result" | sort)" == "$(echo "$expected_result" | sort)" ] \
	&& echo "✅ find_sh.sh OK" \
	|| echo "❌ find_sh.sh KO (got: $result)"

rm -rf file[0-9]*.sh subfolder*
