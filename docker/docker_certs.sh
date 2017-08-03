export HOST=192.168.156.121
export HOST_IP=192.168.56.121
export HOST_IP_2=192.168.0.111
rm -rf ~/cert
mkdir ~/cert
cd ~/cert
openssl genrsa -aes256 -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
openssl genrsa -out server-key.pem 4096
openssl req -subj "/CN=$HOST" -sha256 -new -key server-key.pem -out server.csr
echo subjectAltName = DNS:$HOST,IP:$HOST_IP,IP:$HOST_IP_2,IP:127.0.0.1 > extfile.cnf
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile extfile.cnf
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
echo extendedKeyUsage = clientAuth > extfile.cnf
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile.cnf
rm -v ~/cert/client.csr ~/cert/server.csr
chmod -v 0400 ca-key.pem key.pem server-key.pem
chmod -v 0444 ca.pem server-cert.pem cert.pem
rm -rf ~/.docker
mkdir -pv ~/.docker
cp -v {ca,cert,key}.pem ~/.docker
rm -rf /etc/docker/certs.d
mkdir /etc/docker/certs.d
cp -r ~/cert/* /etc/docker/certs.d/