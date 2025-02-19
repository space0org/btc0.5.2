# Bitcoin 0.5.2 Test Network Setup

This repository contains configuration and documentation for setting up a local Bitcoin 0.5.2 test network using Docker containers.

## Quick Start

1. Clone this repository
2. Run `docker-compose up -d`
3. Verify network with `docker-compose ps`

## Network Configuration

The network consists of three Bitcoin nodes running in Docker containers:
- node1: 172.20.0.2 (ports 8331:8332, 8332:8333)
- node2: 172.20.0.3 (ports 8341:8332, 8342:8333)
- node3: 172.20.0.4 (ports 8351:8332, 8352:8333)

## Configuration Files

### docker-compose.yml
```yaml
version: '3'
services:
  node1:
    build: .
    container_name: bitcoin-node1
    networks:
      bitcoin_net:
        ipv4_address: 172.20.0.2
    ports:
      - "8331:8332"
      - "8332:8333"
    volumes:
      - ./node1:/root/.bitcoin

  node2:
    build: .
    container_name: bitcoin-node2
    networks:
      bitcoin_net:
        ipv4_address: 172.20.0.3
    ports:
      - "8341:8332"
      - "8342:8333"
    volumes:
      - ./node2:/root/.bitcoin

  node3:
    build: .
    container_name: bitcoin-node3
    networks:
      bitcoin_net:
        ipv4_address: 172.20.0.4
    ports:
      - "8351:8332"
      - "8352:8333"
    volumes:
      - ./node3:/root/.bitcoin

networks:
  bitcoin_net:
    ipam:
      config:
        - subnet: 172.20.0.0/16
```

### bitcoin.conf
```ini
# Network
testnet=1
dnsseed=0
upnp=0
listen=1
port=8333
rpcport=8332

# RPC
server=1
rpcuser=bitcoinrpc
rpcpassword=local321
rpcallowip=172.20.0.0/16

# Node Discovery
addnode=172.20.0.2:8333
addnode=172.20.0.3:8333
addnode=172.20.0.4:8333

# Mining
gen=1
genproclimit=1
```

## Troubleshooting

### Common Issues

1. Node Connection Issues
   - Verify network configuration in docker-compose.yml
   - Check bitcoin.conf addnode settings
   - Ensure ports are correctly mapped

2. Mining Issues
   - Verify gen=1 in bitcoin.conf
   - Check genproclimit setting
   - Monitor hashespersec in getinfo output

3. Block Synchronization
   - All nodes should show same block height
   - Check connections between nodes
   - Verify testnet=1 setting

### Verification Commands

Check node status:
```bash
docker exec bitcoin-node1 bitcoind getinfo
```

Check block height:
```bash
docker exec bitcoin-node1 bitcoind getblockcount
```

## Network Verification

A properly functioning network will show:
- All nodes connected (2-5 peers each)
- Active mining (hashespersec > 0)
- Synchronized block height across nodes
- No errors in getinfo output

