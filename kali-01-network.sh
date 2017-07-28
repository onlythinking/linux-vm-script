echo "Configure network."
echo -e "#The primary network interface \n \
		auto eth0 \n \
		iface eth0 inet dhcp \n" > /etc/network/interfaces.d/if-eth0

echo -e "#The secondary network interface \n \
		auto eth1 \n \
		iface eth1 inet static \n \
		address 192.168.1.101 \n \
		netmask 255.255.255.0 \n \
		network 192.168.1.0 \n \
		broadcast 192.168.1.255 \n \
		gateway 192.168.1.1 \n" > /etc/network/interfaces.d/if-eth1
echo "Configure finish ."
