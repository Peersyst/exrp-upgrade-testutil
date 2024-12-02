#!/bin/bash

DEFAULT_NODE_HOME=$PWD/data/node-0
CHAIN_ID=exrp_1440002-1
KEY_NAME=key
MONIKER=node
CUSTOM_DOCKER_FLAGS="--platform=linux/amd64"
COSMOVISOR_IMAGE=cosmovisor:local
EXRPD_IMAGE=peersyst/exrp:latest

# bin/exrpd --home $DEFAULT_NODE_HOME tendermint unsafe-reset-all
docker run $CUSTOM_DOCKER_FLAGS -it --rm --entrypoint "" -v $DEFAULT_NODE_HOME:/root/.exrpd peersyst/exrp:v3.0.0 exrpd tendermint unsafe-reset-all

node src/build-genesis.js data/genesis-state.json $DEFAULT_NODE_HOME/config/genesis.json

#rm -rf $DEFAULT_NODE_HOME/cosmovisor
# docker run $CUSTOM_DOCKER_FLAGS -it --rm --name validator -p 26657:26657 -p 8545:8545 -v $DEFAULT_NODE_HOME:/root/.exrpd $COSMOVISOR_IMAGE initialize
# docker run $CUSTOM_DOCKER_FLAGS -it --rm --name validator -p 26657:26657 -p 8545:8545 -v $DEFAULT_NODE_HOME:/root/.exrpd $COSMOVISOR_IMAGE cosmovisor run start
docker run $CUSTOM_DOCKER_FLAGS -it --rm --entrypoint "" --name validator -v $DEFAULT_NODE_HOME:/root/.exrpd peersyst/exrp:v3.0.0 exrpd start