#!/bin/bash

docker run -v /root:/root --rm -it --entrypoint "" peersyst/xrp-evm-blockchain:latest sh -c "exrpd export > /root/.exrpd/exported-state.json"

mv /root/.exrpd/exported-state.json ./data/genesis-state.json