# certificate-generation-recipies
A collection of scripts and configs for generating SSL keys/CSRs/certs

# CFSSL - localhost and 127.0.0.1

Pretty simple, this creates a certificate that is valid for localhost and 127.0.0.1. The commands are:

```
docker run --rm -v ${PWD}:/cfssl --entrypoint=/bin/bash cfssl/cfssl -c "/go/bin/cfssl gencert \
  -initca /cfssl/ca.json | \
  /go/bin/cfssljson -bare /cfssl/certs/ca"
docker run --rm -v ${PWD}:/cfssl --entrypoint=/bin/bash cfssl/cfssl -c "/go/bin/cfssl gencert \
  -ca /cfssl/certs/ca.pem \
  -ca-key /cfssl/certs/ca-key.pem \
  -config /cfssl/config.json \
  -profile=server \
  /cfssl/localhost.json | \
  /go/bin/cfssljson -bare /cfssl/certs/localhost"
```

A nice shiny localhost cert.

Or you can let the script take care of it... in the cfssl-localhost directory, run:

```
./create_localhost.sh
```
