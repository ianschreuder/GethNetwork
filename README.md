Ethereum Network (Geth)
==========

Docker derived from ethereum/client-go

A few scripts in this project also simplify playing with this image.

## Network Defaults

Set the following variables to isolate the network away from the main public Ethereum network.

* GENESIS_NONCE: set to any hex value
* GENESIS_CHAIN_ID: set to any integer, nodes connect to this when agreed upon

## Review the makefile for tool options

```sh
make
```
