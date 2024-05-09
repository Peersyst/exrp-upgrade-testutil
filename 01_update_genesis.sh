#!/bin/bash

DEFAULT_NODE_HOME=$PWD/data/node-0
CHAIN_ID=exrp_1440002-1
KEY_NAME=key
MONIKER=node
CUSTOM_DOCKER_FLAGS="--platform=linux/amd64"
COSMOVISOR_IMAGE=cosmovisor:local

docker run $CUSTOM_DOCKER_FLAGS -it --rm --entrypoint "" -v $DEFAULT_NODE_HOME:/root/.exrpd peersyst/xrp-evm-blockchain:latest exrpd tendermint unsafe-reset-all
rm -rf $DEFAULT_NODE_HOME/cosmovisor

node src/build-genesis.js genesis-state.json $DEFAULT_NODE_HOME/config/genesis.json

docker run $CUSTOM_DOCKER_FLAGS -it --rm --name validator -p 26657:26657 -p 8545:8545 -v $DEFAULT_NODE_HOME:/root/.exrpd $COSMOVISOR_IMAGE initialize
docker run $CUSTOM_DOCKER_FLAGS -it --rm --name validator -p 26657:26657 -p 8545:8545 -v $DEFAULT_NODE_HOME:/root/.exrpd $COSMOVISOR_IMAGE cosmovisor run start
