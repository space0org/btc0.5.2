# Troubleshooting Guide

## Common Issues and Solutions

### 1. Node Connection Issues

#### Symptoms
- Nodes show 0 connections
- Blocks not synchronizing
- Mining not working

#### Solutions
1. Check network configuration:
```bash
docker network inspect bitcoin-network_bitcoin_net
```

2. Verify node configuration:
```bash
docker exec bitcoin-node1 cat /root/.bitcoin/bitcoin.conf
```

3. Ensure ports are correctly mapped:
```bash
docker-compose ps
```

### 2. Mining Issues

#### Symptoms
- hashespersec = 0
- No new blocks being generated
- Balance remains 0

#### Solutions
1. Verify mining configuration:
```bash
grep "gen=" /path/to/bitcoin.conf
```

2. Check mining status:
```bash
docker exec bitcoin-node1 bitcoind getmininginfo
```

3. Restart mining:
```bash
docker exec bitcoin-node1 bitcoind setgenerate true
```

### 3. Block Synchronization Issues

#### Symptoms
- Different block heights between nodes
- Transactions not confirming
- Network seems stalled

#### Solutions
1. Check block heights:
```bash
for i in {1..3}; do
  echo "Node $i:"
  docker exec bitcoin-node$i bitcoind getblockcount
done
```

2. Verify network connectivity:
```bash
for i in {1..3}; do
  echo "Node $i:"
  docker exec bitcoin-node$i bitcoind getinfo
done
```

3. Reset blockchain data:
```bash
docker-compose down
rm -rf node*/
docker-compose up -d
```

## Verification Commands

### Basic Status Check
```bash
docker exec bitcoin-node1 bitcoind getinfo
```

### Network Status
```bash
docker exec bitcoin-node1 bitcoind getpeerinfo
```

### Mining Status
```bash
docker exec bitcoin-node1 bitcoind getmininginfo
```

## Known Issues

1. Initial Connection Delay
   - Symptom: Nodes may take up to 30 seconds to establish connections
   - Solution: Wait for network initialization to complete

2. RPC Connection Issues
   - Symptom: "Connection refused" errors
   - Solution: Verify rpcallowip settings in bitcoin.conf

3. Memory Usage
   - Symptom: High memory usage during mining
   - Solution: Adjust genproclimit in bitcoin.conf
