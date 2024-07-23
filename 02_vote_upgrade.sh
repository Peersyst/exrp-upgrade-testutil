#!/bin/bash

DEFAULT_NODE_HOME=$PWD/data/node-0
PROPOSAL_ID=37
CONTAINER_NAME=validator

CUSTOM_DOCKER_FLAGS="--platform linux/amd64"

exrpd() {
    docker exec -it $CONTAINER_NAME exrpd $@
}
export -f exrpd

# Copy the upgrade-proposal.json file inside the container
# docker cp data/upgrade-proposal.json $CONTAINER_NAME:/root/upgrade-proposal.json
#
# exrpd tx gov submit-proposal /root/upgrade-proposal.json --from alice --gas-prices 8000000000000axrp --gas 400000 --yes

exrpd tx poa add-validator --address ethm1gzsalqy0rru2pe6az9ulk69hg2dnm22wrw3sl7 --moniker flowdesk --pubkey '{"@type":"/cosmos.crypto.ed25519.PubKey","key":"ed0xYtgWL/bLw7xe8ldSUW/NIU2ZgSWFhfKsUfpT1gc="}' --title 'Add Flowdesk validator' --summary 'Add Flowdesk validator' --from alice --gas-prices 8000000000000axrp --gas 400000 --yes
sleep 10
exrpd tx gov vote $PROPOSAL_ID yes --from alice --gas-prices 800000000000axrp --yes
sleep 60
exrpd query gov proposals