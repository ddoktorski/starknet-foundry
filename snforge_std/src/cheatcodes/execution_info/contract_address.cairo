use super::{ExecutionInfoMock, cheat_execution_info, Operation, ContractAddress};

pub fn start_cheat_contract_address_global(contract_address: ContractAddress) {
    let mut execution_info: ExecutionInfoMock = Default::default();

    execution_info.contract_address = Operation::StartGlobal(contract_address);

    cheat_execution_info(execution_info);
}

pub fn stop_cheat_contract_address_global() {
    let mut execution_info: ExecutionInfoMock = Default::default();

    execution_info.contract_address = Operation::StopGlobal;

    cheat_execution_info(execution_info);
}
