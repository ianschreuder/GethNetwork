Ethereum Network (Geth)
==========

Docker derived from ethereum/client-go

A few scripts in this project also simplify playing with this image.

## Network Defaults

Set the following variables to isolate the network away from the main public Ethereum network.

* GENESIS_NONCE: set to any hex value
* GENESIS_CHAIN_ID: set to any integer, nodes connect to this when agreed upon

## General Docker Commands

Build the container

```sh
docker build .
```

Run a node

```sh
docker run <image name>
```
