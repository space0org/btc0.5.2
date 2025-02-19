# Bitcoin 0.5.2 Test Network Setup Guide

This repository contains configuration and documentation for setting up a local Bitcoin 0.5.2 test network using Docker containers.

## Overview

This setup creates a private Bitcoin test network with three interconnected nodes, each running in its own Docker container. The network is configured to mine blocks and process transactions in a controlled environment.

## Network Architecture

```
                   Docker Network (172.20.0.0/16)
                            |
        +------------------+------------------+
        |                  |                  |
    Node 1           Node 2           Node 3
  172.20.0.2       172.20.0.3       172.20.0.4
    8331:8332       8341:8332       8351:8332
    8332:8333       8342:8333       8352:8333
```

## Prerequisites

- Docker
- Docker Compose
- Git

## Quick Start

1. Clone this repository:
```bash
git clone https://github.com/space0org/bitcoin-testnet-docker.git
cd bitcoin-testnet-docker
```

2. Start the network:
```bash
docker-compose up -d
```

3. Verify the network:
```bash
docker-compose ps
```

## Configuration Files

- [Docker Configuration](config/docker-compose.yml)
- [Node Configuration](config/bitcoin.conf)
- [Dockerfile](config/Dockerfile)

## Verification

Check node status:
```bash
docker exec bitcoin-node1 bitcoind getinfo
```

Expected output should show:
- Connections > 0
- Active mining (hashespersec > 0)
- Synchronized block height
- No errors

## Troubleshooting

See the [Troubleshooting Guide](troubleshooting/README.md) for common issues and solutions.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
