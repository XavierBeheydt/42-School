#!/bin/bash

ifconfig | grep ether | grep -oE '([0-9a-f]{2}:){5}[0-9a-f]{2}'
