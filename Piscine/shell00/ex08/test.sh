#!/bin/bash


touch test{1,2,3,4,5,6}~ test{1,2,3,4} \#test{1,2,3,4}\#

bash clean

nb_file=$(ls | wc -l)
[ "$nb_file" -eq "6" ] && echo "✅ clean OK ($nb_file files left)" || echo "❌ clean KO ($nb_file files left, expected 6)"

rm -rf test[0-9]*
