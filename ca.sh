#!/bin/bash
#
source init
# Creates the private key
openssl genrsa -out certs/ca.key 4096
# creates the CA certificate
openssl req -x509 -new -nodes -key certs/ca.key -sha256 -days 1024 -config openssl-test-ca.cnf -out certs/ca.pem -extensions v3_ca

