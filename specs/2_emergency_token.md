# Specification - OracleNFT

## Parameter

## User Action

1. Mint - Redeemer `EMint {current_timestamp, account_address}`

   - Must be signed by owner
   - The `AssetName` must be in form of hash of `ValidatorHash` + `StakeCredentialHash`
   - There must be 1 input from `account_address` with datum information of account owner.
   - There must be 1 output to `account_address`
   - The output datum to `account_address` with `valid_since` after current signing interval

2. Burn - Redeemer `EBurn`

   - The current policy id only has negative minting value in transaction body.
