#!/bin/bash

rm -rf id*
ssh-keygen -t rsa -f id_rsa -N ""
rm -f id_rsa
mv id_rsa.pub id_rsa_pub

test -f "id_rsa_pub" && echo "✅ \`id_rsa_pub\` file exists!" || echo "❌ \`id_rsa_pub\` file not exists!"
cat id_rsa_pub
