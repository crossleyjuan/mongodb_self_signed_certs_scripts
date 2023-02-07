# Name of the replicaset yaml
export METADATANAME=crossmachine
# internal domain inside openshift
export DOMAIN=crossdomain
# external domain
export EXTERNALDOMAIN=crossdomain

export SERVER="${METADATANAME}"
export DNSSERVER=*.${DOMAIN}

echo "${SERVER}"
envsubst < "openssl-test-server.cnf.template" >  "openssl-test-server.cnf"

openssl genrsa -out certs/${SERVER}.key 4096

openssl req -new -key certs/${SERVER}.key -out certs/${SERVER}.csr -config openssl-test-server.cnf

openssl x509 -sha256 -req -days 365 -in certs/${SERVER}.csr -CA certs/ca-pem -CAkey certs/ca.key -CAcreateserial -out certs/${SERVER}.crt -extfile openssl-test-server.cnf -extensions v3_req

cat certs/${SERVER}.crt certs/${SERVER}.key > certs/${SERVER}-pem
