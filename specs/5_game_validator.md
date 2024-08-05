# Specification - GameValidator

## Parameter

## Datum

- `oracle_nft`: The policy id of `OracleNFT`
- `players`: The pub key hashes of players involved
- `quorem`: The number of winner of game to authorize ending game

## User Action=

1. Close game - Redeemer `CloseGame`

   - Only 1 reference input from oracle address
   - The transaction is signed by all `players`
   - The transaction is signed by all `operation_key`

2. Cancel game - Redeemer `CancelGame`

   - The transaction is signed by all `players`
