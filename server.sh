#!/bin/bash
#
source init

# Name of the replicaset yaml
export METADATANAME=test-replica-set
# internal domain inside openshift
export DOMAIN=test-replica-set-svc.mongodbops3.svc.cluster.local

for rs in 0 1 2 
do
	export SERVER="${METADATANAME}-${rs}"
	export DNSSERVER=${SERVER}.${DOMAIN}

	echo "${SERVER}"
	envsubst < "openssl-test-server.cnf.template" >  "openssl-test-server.cnf"

	openssl genrsa -out certs/${SERVER}.key 4096

	openssl req -new -key certs/${SERVER}.key -out certs/${SERVER}.csr -config openssl-test-server.cnf

	openssl x509 -sha256 -req -days 365 -in certs/${SERVER}.csr -CA certs/ca-pem -CAkey certs/ca.key -CAcreateserial -out certs/${SERVER}.crt -extfile openssl-test-server.cnf -extensions v3_req

	cat certs/${SERVER}.crt certs/${SERVER}.key > certs/${SERVER}-pem
done
