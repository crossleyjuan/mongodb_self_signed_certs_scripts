#!/bin/bash
#
source init

# Name of the server (simple name)
export SERVERNAME=host1
# Domain name to be used, the FQDN will be SERVER_NAME.DOMAIN
export DOMAIN=somedomain.com

export SERVER="${SERVERNAME}"
export DNSSERVER=${SERVER}.${DOMAIN}

echo "${SERVER}"
envsubst < "openssl-test-server.cnf.template" >  "openssl-test-server-${SERVER}.cnf"

openssl genrsa -out certs/${SERVER}.key 4096

openssl req -new -key certs/${SERVER}.key -out certs/${SERVER}.csr -config openssl-test-server-${SERVER}.cnf

openssl x509 -sha256 -req -days 365 -in certs/${SERVER}.csr -CA certs/ca.pem -CAkey certs/ca.key -CAcreateserial -out certs/${SERVER}.crt -extfile openssl-test-server-${SERVER}.cnf -extensions v3_req

cat certs/${SERVER}.crt certs/${SERVER}.key > certs/${SERVER}.pem
