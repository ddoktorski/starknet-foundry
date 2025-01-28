use super::super::_cheatcode::handle_cheatcode;

// Generates a random number that is used for creating data for fuzz tests
pub fn generate_arg<T, +Serde<T>, +Drop<T>, +Into<T, felt252>>(min_value: T, max_value: T) -> T {
    let mut res = handle_cheatcode(
        starknet::testing::cheatcode::<
            'generate_arg'
        >(array![min_value.into(), max_value.into()].span())
    );
    Serde::deserialize(ref res).unwrap()
}
