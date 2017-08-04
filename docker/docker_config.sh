touch /etc/docker/daemon.json
echo '{
    "hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:2376"],
    "tls": true,
    "tlscacert": "/etc/docker/certs.d/ca.pem",
    "tlscert": "/etc/docker/certs.d/server-cert.pem",
    "tlskey": "/etc/docker/certs.d/server-key.pem",
    "tlsverify": true
}' >> /etc/docker/daemon.json
cp /lib/systemd/system/docker.service /etc/systemd/system/
sed -i 's/\ -H\ fd:\/\///g' /etc/systemd/system/docker.service
systemctl daemon-reload
service docker restart
