#!/bin/bash

rm -f testShell00*

touch -t 06012342 testShell00
chmod 455 testShell00

EXPECTED_PERMS="-r--r-xr-x"
EXPECTED_DAY="1"
EXPECTED_MONTH="Jun"
EXPECTED_TIME="23:42"

info=$(LC_ALL=C ls -l testShell00 | awk '{print $1, $6, $7, $8}')
perms=$(echo "$info" | awk '{print $1}')
month=$(echo "$info" | awk '{print $2}')
day=$(echo "$info" | awk '{print $3}')
time=$(echo "$info" | awk '{print $4}')

[ "$perms" == "$EXPECTED_PERMS" ] && echo "✅ permissions OK ($perms)" || echo "❌ permissions KO ($perms, expected $EXPECTED_PERMS)"
[ "$month" == "$EXPECTED_MONTH" ] && echo "✅ month OK ($month)" || echo "❌ month KO ($month, expected $EXPECTED_MONTH)"
[ "$day" == "$EXPECTED_DAY" ] && echo "✅ day OK ($day)" || echo "❌ day KO ($day, expected $EXPECTED_DAY)"
[ "$time" == "$EXPECTED_TIME" ] && echo "✅ hour:minute OK ($time)" || echo "❌ hour:minute KO ($time, expected $EXPECTED_TIME)"

tar -cf testShell00.tar testShell00
rm -f testShell00
