## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

or

```shell
$ create ContraName --rpc-url 127.0.0.1:8545 --broadcast  --interactive
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

## useful commands

get information from a contract

```shell
$ cast call contractAddress "function(args)(return types)" args --rpc-url 127.0.0.1:8545 --private-key 0x00
```

send a transaction to contract

```shell
$ cast send contractAddress "functionName(args)" argsValue --rpc-url 127.0.0.1:8545 --private-key 0x00
```

convert 0x000 to decimal

```shell
$ cast --to-base 0x000 dec
```
