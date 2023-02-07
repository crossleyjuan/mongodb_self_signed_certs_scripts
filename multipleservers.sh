#!/bin/bash
#
source init

# Name of the replicaset yaml
export SERVER_NAMES=( host1 host2 host3 )
# internal domain inside openshift
export DOMAIN=somedomain.com

for HOST in "${SERVER_NAMES[@]}" 
do
	export SERVER=${HOST}
	export DNSSERVER=${SERVER}.${DOMAIN}

	echo "${SERVER}"
	envsubst < "openssl-test-server.cnf.template" >  "openssl-test-server-${SERVER}.cnf"

	openssl genrsa -out certs/${SERVER}.key 4096

	openssl req -new -key certs/${SERVER}.key -out certs/${SERVER}.csr -config openssl-test-server-${SERVER}.cnf

	openssl x509 -sha256 -req -days 365 -in certs/${SERVER}.csr -CA certs/ca.pem -CAkey certs/ca.key -CAcreateserial -out certs/${SERVER}.crt -extfile openssl-test-server-${SERVER}.cnf -extensions v3_req

	cat certs/${SERVER}.crt certs/${SERVER}.key > certs/${SERVER}.pem
done
