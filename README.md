# Certificates scripts

## Update the values in the configuration files

Open and update the values according to your environment in the following files:

* openssl-test-ca.cnf
* openssl-test-server.cnf.template (this is a template, please keep the variables or use the variables instead of hardcoding the server names)
* openssl-test-client.cnf.template (this is a template)

## Create the ca

```bash
./ca.sh
```

this will create some files in the certs folder, the important ones are the .key and pem

## Create multiple hosts certificates

The following steps allows to create one certificate per server if they are using the same settings and domain

open the file "multipleservers.sh" and change the variables  SERVERNAMES and DOMAIN according to your environment, for example:


# Name of the servers (simple name)
export SERVER_NAMES=( h1sa1 h1sa2  h2sa3 )
# Domain name to be used, the FQDN will be SERVER_NAME.DOMAIN
export DOMAIN=mycompanydomain.com


execute the script:
```bash
./multipleservers.sh
```

This will create 1 pem file per server in the output folder certs


## Create single host certificate

The following steps allows to create one certificate 

open the file "single-server.sh" and change the variables  SERVERNAME and DOMAIN according to your environment, for example:

# Name of the servers (simple name)
export SERVER_NAME=h1sa1
# Domain name to be used, the FQDN will be SERVER_NAME.DOMAIN
export DOMAIN=mycompanydomain.com

execute the script:
```bash
./single-server.sh
```

This will create 1 pem file in the output folder certs


