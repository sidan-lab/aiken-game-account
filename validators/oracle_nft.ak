use aiken/transaction.{OutputReference, ScriptContext}
use aiken_game_account/types.{MintPolarity}
use aiken_game_account/validators/oracle_nft.{oracle_nft_logic}

validator(utxo_ref: OutputReference) {
  pub fn oracle_nft(redeemer: MintPolarity, context: ScriptContext) -> Bool {
    oracle_nft_logic(utxo_ref, redeemer, context)
  }
}
