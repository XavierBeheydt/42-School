#!/bin/bash

mkdir -p subfolder subfolder.sh
touch file{1,2,3}.sh \
	.file{12,13} \
	subfolder/file{4,5,6}.sh \
	subfolder.sh/file{7,8,9,10.sh,11.sh}
ln -sf file1 file1sym
ln -sf subfolder subfoldersym

result=$(bash count_files.sh)
expected_result="18"

[ "$(echo "$result" | sort)" == "$(echo "$expected_result" | sort)" ] \
	&& echo "✅ count_files.sh OK" \
	|| echo "❌ count_files.sh KO (got: $result)"

rm -rf file[0-9]*.sh subfolder* .file[0-9]* file1sym
