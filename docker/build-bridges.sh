te docker0 bridge
# restart docker systemd service
# confirm new outgoing NAT masquerade is set up
#
# reference
#     https://docs.docker.com/engine/userguide/networking/default_network/build-bridges/
#


sudo brctl addbr docker0
sudo ip addr add 192.168.10.1/24 dev docker0
sudo ip link set dev docker0 up
ip addr show docker0
sudo systemctl restart docker
sudo iptables -t nat -L -n

exit(0)
