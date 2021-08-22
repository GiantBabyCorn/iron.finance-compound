// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

interface IFirebirdRoute {
    function acceptContractDepositor() external view returns (bool);

    function deposit(
        address _vault,
        uint256 _amount,
        uint256 _min_mint_amount
    ) external;

    function exit(address _vault, uint256 _min_output_amount) external;

    function governance() external view returns (address);

    function governanceRecoverUnsupported(
        address _token,
        uint256 amount,
        address to
    ) external;

    function harvestAllStrategies(address _vault) external;

    function harvestStrategy(address _vault, address _strategy) external;

    function initialize(address _vaultMaster) external;

    function setAcceptContractDepositor(bool _acceptContractDepositor) external;

    function setGovernance(address _governance) external;

    function setStrategist(address _strategist) external;

    function setVaultMaster(address _vaultMaster) external;

    function strategist() external view returns (address);

    function unwhitelistContract(address _contract) external;

    function vaultMaster() external view returns (address);

    function whitelistContract(address _contract) external;

    function whitelistedContract(address) external view returns (bool);

    function withdraw(
        address _vault,
        uint256 _shares,
        uint256 _min_output_amount
    ) external;
}
