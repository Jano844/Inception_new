#!/bin/sh

# (its the entrypoint.sh)

# can create the ssl_certificate with open ssl here, but for simplification
# i just createt them only once and have them in the conf/ssl directory

# start the main procces
exec nginx -g 'daemon off;' 
