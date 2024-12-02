#!/bin/bash

DEFAULT_NODE_HOME=$PWD/data/node-0
PROPOSAL_ID=43
CONTAINER_NAME=validator
VERSION=4.0.0

CUSTOM_DOCKER_FLAGS="--platform linux/amd64"

exrpd() {
    docker exec -it $CONTAINER_NAME exrpd $@
}
export -f exrpd

# Copy the upgrade-proposal.json file inside the container
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed 's/%VERSION%/'"$VERSION"'/g' "data/upgrade-proposal.json" > data/upgrade-proposal-tmp.json
else
  sed 's/%VERSION%/'"'$VERSION'"'/g' "data/upgrade-proposal.json" > data/upgrade-proposal-tmp.json
fi
docker cp data/upgrade-proposal-tmp.json $CONTAINER_NAME:/root/upgrade-proposal.json
# rm data/upgrade-proposal-tmp.json
exrpd tx gov submit-proposal /root/upgrade-proposal.json --from alice --gas-prices 8000000000000axrp --gas 400000 --broadcast-mode async --yes

# exrpd tx poa add-validator --address ethm1gzsalqy0rru2pe6az9ulk69hg2dnm22wrw3sl7 --moniker flowdesk --pubkey '{"@type":"/cosmos.crypto.ed25519.PubKey","key":"ed0xYtgWL/bLw7xe8ldSUW/NIU2ZgSWFhfKsUfpT1gc="}' --title 'Add Flowdesk validator' --summary 'Add Flowdesk validator' --from alice --gas-prices 8000000000000axrp --gas 400000 --yes --broadcast-mode async --deposit 50000000000000000000axrp
sleep 10
exrpd tx gov vote $PROPOSAL_ID yes --from alice --gas-prices 800000000000axrp --yes --broadcast-mode async
sleep 60
exrpd query gov proposals
