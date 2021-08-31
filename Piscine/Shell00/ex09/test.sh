#!/bin/bash

cd "$(dirname "$0")" || exit 1

printf '%041d42' 0 > .sample_ok
printf '%050d' 0 > .sample_ko

file -C -m ft_magic
file -m ft_magic.mgc .sample_ok .sample_ko

rm -f .sample_ok .sample_ko ft_magic.mgc
