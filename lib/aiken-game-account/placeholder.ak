use aiken/bytearray
use aiken/hash.{blake2b_256}
use aiken/transaction.{InlineDatum, Input, NoDatum, Output, OutputReference}
use aiken/transaction/value.{PolicyId, Value, add, from_asset}
use aiken_game_account/types.{
  AccountNormalDatum, AccountOracleDatum, EmergencyUnlockPhase1,
  EmergencyUnlockPhase2,
}
use aiken_game_account/utils.{get_emergency_token_name}
use sidan_placeholder/address.{mock_pub_key_address, mock_script_address}
use sidan_placeholder/key_hex.{
  mock_policy_id, mock_pub_key_hex, mock_script_hash_hex,
}
use sidan_placeholder/output_reference.{mock_utxo_ref}

// Smart contract specific placeholders
pub fn mock_account_oracle_policy_id() -> PolicyId {
  mock_policy_id(0)
}

pub fn mock_account_oracle_address() {
  mock_script_address(1, None)
}

pub fn mock_fee_ref_token() {
  mock_policy_id(1)
}

pub fn mock_fee_info_address() {
  mock_script_address(2, None)
}

pub fn mock_operation_key() {
  mock_pub_key_hex(1)
}

pub fn mock_stop_key() {
  mock_pub_key_hex(2)
}

pub fn mock_emergency_token() {
  mock_policy_id(2)
}

pub fn mock_user_vkey_hex() {
  mock_pub_key_hex(3)
}

pub fn mock_user_address() {
  mock_pub_key_address(3, None)
}

pub fn ada_asset_class() {
  ("", "")
}

pub fn mock_token_asset_class() {
  (mock_policy_id(4), "A potentially very long name")
}

pub fn mock_account_oracle_datum() {
  AccountOracleDatum {
    oracle_nft: mock_account_oracle_policy_id(),
    oracle_address: mock_account_oracle_address(),
    operation_key: mock_operation_key(),
    stop_key: mock_stop_key(),
  }
}

pub fn mock_account_oracle_output(oracle_datum: AccountOracleDatum) -> Output {
  Output {
    address: mock_account_oracle_address(),
    value: from_asset(mock_account_oracle_policy_id(), "", 1)
      |> add(#"", #"", 2_000_000),
    datum: InlineDatum(oracle_datum),
    reference_script: None,
  }
}

pub fn mock_account_oracle_ref_input() -> Input {
  Input {
    output_reference: mock_utxo_ref(0, 0),
    output: mock_account_oracle_output(mock_account_oracle_datum()),
  }
}

pub fn mock_user_output(value: Value) -> Output {
  Output {
    address: mock_user_address(),
    value,
    datum: NoDatum,
    reference_script: None,
  }
}

pub fn mock_fee_address() {
  mock_pub_key_address(1, None)
}

pub fn mock_fee_output(
  long_token_quantity: Int,
  min_fee: Int,
  percentage_fee_times_10k: Int,
) -> Output {
  let percentage_fee = long_token_quantity * percentage_fee_times_10k / 10000
  let fee_in_lovelace =
    if percentage_fee > min_fee {
      percentage_fee
    } else {
      min_fee
    }
  Output {
    address: mock_fee_address(),
    value: from_asset("", "", fee_in_lovelace),
    datum: NoDatum,
    reference_script: None,
  }
}

pub fn script_hash_4_1() -> ByteArray {
  bytearray.concat(mock_script_hash_hex(4), #"01")
    |> blake2b_256()
    |> bytearray.take(28)
}

pub fn script_hash_4_2() -> ByteArray {
  bytearray.concat(mock_script_hash_hex(4), #"02")
    |> blake2b_256()
    |> bytearray.take(28)
}

pub fn script_hash_4_3() -> ByteArray {
  bytearray.concat(mock_script_hash_hex(4), #"03")
    |> blake2b_256()
    |> bytearray.take(28)
}

pub fn script_hash_4_4() -> ByteArray {
  bytearray.concat(mock_script_hash_hex(4), #"04")
    |> blake2b_256()
    |> bytearray.take(28)
}

pub fn script_hash_5_1() -> ByteArray {
  bytearray.concat(mock_script_hash_hex(5), #"01")
    |> blake2b_256()
    |> bytearray.take(28)
}

pub fn mock_account_address() {
  mock_script_address(3, None)
}

pub fn mock_another_account_address() {
  mock_script_address(4, None)
}

pub fn mock_emergency_unlock_phase1_output(owner: ByteArray) -> Output {
  Output {
    address: mock_account_address(),
    value: from_asset("", "", 2_000_000),
    datum: InlineDatum(EmergencyUnlockPhase1 { owner }),
    reference_script: None,
  }
}

pub fn mock_emergency_unlock_phase1_utxo(variation: Int) -> OutputReference {
  mock_utxo_ref(0, 20 + variation)
}

pub fn mock_emergency_unlock_phase1_input(variation: Int) -> Input {
  Input {
    output_reference: mock_emergency_unlock_phase1_utxo(variation),
    output: mock_emergency_unlock_phase1_output(mock_user_vkey_hex()),
  }
}

pub fn mock_emergency_unlock_phase2_output(valid_since: Int, minter: ByteArray) {
  Output {
    address: mock_account_address(),
    value: from_asset("", "", 2_000_000)
      |> add(
          mock_emergency_token(),
          get_emergency_token_name(mock_account_address()),
          1,
        ),
    datum: InlineDatum(EmergencyUnlockPhase2 { valid_since, minter }),
    reference_script: None,
  }
}

pub fn mock_emergency_unlock_phase2_utxo(variation: Int) -> OutputReference {
  mock_utxo_ref(0, 30 + variation)
}

pub fn mock_emergency_unlock_phase2_input(
  variation: Int,
  valid_since: Int,
  minter: ByteArray,
) -> Input {
  Input {
    output_reference: mock_emergency_unlock_phase2_utxo(variation),
    output: mock_emergency_unlock_phase2_output(valid_since, minter),
  }
}

pub fn mock_account_input(variation: Int) -> Input {
  Input {
    output_reference: mock_utxo_ref(0, 10 + variation),
    output: mock_game_output(500_000_000),
  }
}

pub fn mock_game_output(lovelace: Int) -> Output {
  Output {
    address: mock_account_address(),
    value: from_asset("", "", lovelace),
    datum: InlineDatum(AccountNormalDatum),
    reference_script: None,
  }
}

pub fn mock_game_input(variation: Int) -> Input {
  Input {
    output_reference: mock_utxo_ref(0, 10 + variation),
    output: mock_game_output(500_000_000),
  }
}

pub fn mock_emergency_initiation_output(owner: ByteArray) -> Output {
  Output {
    address: mock_account_address(),
    value: from_asset("", "", 2_000_000),
    datum: InlineDatum(EmergencyUnlockPhase1 { owner }),
    reference_script: None,
  }
}

pub fn mock_emergency_initiation_input(variation: Int) -> Input {
  Input {
    output_reference: mock_utxo_ref(0, 20 + variation),
    output: mock_emergency_initiation_output(mock_user_vkey_hex()),
  }
}

pub fn mock_emergency_action_output(valid_since: Int, minter: ByteArray) {
  Output {
    address: mock_account_address(),
    value: from_asset("", "", 2_000_000)
      |> add(
          mock_emergency_token(),
          get_emergency_token_name(mock_account_address()),
          1,
        ),
    datum: InlineDatum(EmergencyUnlockPhase2 { valid_since, minter }),
    reference_script: None,
  }
}

pub fn mock_emergency_action_input(
  variation: Int,
  valid_since: Int,
  minter: ByteArray,
) -> Input {
  Input {
    output_reference: mock_utxo_ref(0, 30 + variation),
    output: mock_emergency_action_output(valid_since, minter),
  }
}
