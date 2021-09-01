#!/bin/bash

cd "$(dirname "$0")" || exit 1

SANDBOX=$(mktemp -d)
cat > "$SANDBOX/ifconfig" <<'FAKE'
#!/bin/bash
cat <<OUT
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.10  netmask 255.255.255.0  broadcast 192.168.1.255
        ether 04:42:1a:95:c0:e6  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)

wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.5  netmask 255.255.255.0  broadcast 10.0.0.255
        ether d6:1a:e0:93:1d:1e  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        loop  txqueuelen 1000  (Local Loopback)
OUT
FAKE
chmod +x "$SANDBOX/ifconfig"

result=$(PATH="$SANDBOX:$PATH" bash MAC.sh)
expected=$'04:42:1a:95:c0:e6\nd6:1a:e0:93:1d:1e'

[ "$result" == "$expected" ] \
	&& echo "✅ MAC.sh OK" \
	|| echo "❌ MAC.sh KO (got: $result)"

rm -rf "$SANDBOX"
