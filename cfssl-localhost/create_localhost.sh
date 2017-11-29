#!/bin/bash
# create CA
if [ ! -f certs/ca-key.pem ]; then
  echo "ca-key.pem doesn't exist.  creating.."
  docker run --rm -v ${PWD}:/cfssl --entrypoint=/bin/bash cfssl/cfssl -c "/go/bin/cfssl gencert \
    -initca /cfssl/ca.json | \
    /go/bin/cfssljson -bare /cfssl/certs/ca"
else
  echo "certs/ca-key.pem exists."
fi

# create cert
if [ ! -f certs/localhost-key.pem ]; then
  echo "certs/localhost-key.pem doesn't exist.  creating..."
  docker run --rm -v ${PWD}:/cfssl --entrypoint=/bin/bash cfssl/cfssl -c "/go/bin/cfssl gencert \
    -ca /cfssl/certs/ca.pem \
    -ca-key /cfssl/certs/ca-key.pem \
    -config /cfssl/config.json \
    -profile=server \
    /cfssl/localhost.json | \
    /go/bin/cfssljson -bare /cfssl/certs/localhost"
else
  echo "certs/localhost-key.pem already exists. skipping."
fi
