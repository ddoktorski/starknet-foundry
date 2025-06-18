use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait, DeclareResultTrait, interact_with_state};

use contract_state::IHelloStarknetDispatcher;
use contract_state::IHelloStarknetDispatcherTrait;
use contract_state::HelloStarknet;
use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap().contract_class();
    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    contract_address
}

#[test]
fn test_interact_with_state() {
    let contract_address = deploy_contract("HelloStarknet");
    let dispatcher = IHelloStarknetDispatcher { contract_address };

    assert(dispatcher.get_balance() == 0, 'Wrong balance');

    interact_with_state(
        contract_address,
        || {
            let mut state = HelloStarknet::contract_state_for_testing();
            state.balance.write(987);
        },
    );

    assert(dispatcher.get_balance() == 987, 'Wrong balance');
    dispatcher.increase_balance(13);
    assert(dispatcher.get_balance() == 1000, 'Wrong balance');
}

#[test]
fn test_interact_with_state_return() {
    let contract_address = deploy_contract("HelloStarknet");
    let dispatcher = IHelloStarknetDispatcher { contract_address };

    assert(dispatcher.get_balance() == 0, 'Wrong balance');

    let res = interact_with_state(
        contract_address,
        || -> felt252 {
            let mut state = HelloStarknet::contract_state_for_testing();
            state.balance.write(111);
            state.balance.read()
        },
    );

    assert(res == 111, 'Wrong balance');
}
