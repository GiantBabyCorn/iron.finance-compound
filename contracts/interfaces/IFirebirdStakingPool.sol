// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

interface IFirebirdStakingPool {
    event Commission(
        address indexed user,
        address indexed referrer,
        uint256 amount
    );
    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event EmergencyWithdraw(
        address indexed user,
        uint256 indexed pid,
        uint256 amount
    );
    event Harvest(address indexed user, uint256 indexed pid, uint256 amount);
    event LogPoolAddition(
        uint256 indexed pid,
        uint256 allocPoint,
        address indexed lpToken,
        address indexed rewarder
    );
    event LogRewardPerSecond(uint256 rewardPerSecond);
    event LogSetPool(
        uint256 indexed pid,
        uint256 allocPoint,
        address indexed rewarder
    );
    event LogUpdatePool(
        uint256 indexed pid,
        uint256 lastRewardTime,
        uint256 lpSupply,
        uint256 accHopePerShare
    );
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event WithdrawFee(
        address indexed user,
        uint256 indexed pid,
        uint256 amount,
        uint256 fee
    );

    function add(
        uint256 _allocPoint,
        address _lpToken,
        address _rewarder,
        uint256 _lastRewardTime
    ) external;

    function commissionPercent() external view returns (uint256);

    function deposit(uint256 _pid, uint256 _amount) external;

    function depositWithRef(
        uint256 _pid,
        uint256 _amount,
        address _referrer
    ) external;

    function devFund() external view returns (address);

    function devPercent() external view returns (uint256);

    function emergencyWithdraw(uint256 _pid) external;

    function enterStaking(uint256 _amount) external;

    function enterStakingWithRef(uint256 _amount, address _referrer) external;

    function governanceRecoverUnsupported(
        address _token,
        uint256 _amount,
        address _to
    ) external;

    function halvingChecked() external view returns (bool);

    function harvestAllRewards() external;

    function harvestAndRestake() external;

    function hope() external view returns (address);

    function initialize(
        address _hope,
        uint256 _totalRewardPerSecond,
        uint256 _startTime
    ) external;

    function leaveStaking(uint256 _amount) external;

    function massUpdatePools() external;

    function nextHalvingTime() external view returns (uint256);

    function owner() external view returns (address);

    function pendingReward(uint256 _pid, address _user)
        external
        view
        returns (uint256);

    function poolEarlyWithdrawFee(uint256) external view returns (uint256);

    function poolInfo(uint256)
        external
        view
        returns (
            address lpToken,
            uint256 allocPoint,
            uint256 lastRewardTime,
            uint256 accHopePerShare,
            bool isStarted,
            uint256 startTime
        );

    function poolLength() external view returns (uint256);

    function poolLockedTime(uint256) external view returns (uint256);

    function renounceOwnership() external;

    function reserveFund() external view returns (address);

    function reservePercent() external view returns (uint256);

    function resetStartTime(uint256 _startTime) external;

    function rewardHalvingRate() external view returns (uint256);

    function rewardPerSecond() external view returns (uint256);

    function rewardReferral() external view returns (address);

    function rewarder(uint256) external view returns (address);

    function set(
        uint256 _pid,
        uint256 _allocPoint,
        address _rewarder
    ) external;

    function setCommissionPercent(uint256 _commissionPercent) external;

    function setDevFund(address _devFund) external;

    function setDevPercent(uint256 _devPercent) external;

    function setHalvingChecked(bool _halvingChecked) external;

    function setPoolLockedTimeAndFee(
        uint256 _pid,
        uint256 _lockedTime,
        uint256 _earlyWithdrawFee
    ) external;

    function setReserveFund(address _reserveFund) external;

    function setReservePercent(uint256 _reservePercent) external;

    function setRewardHalvingRate(uint256 _rewardHalvingRate) external;

    function setRewardReferral(address _rewardReferral) external;

    function setTotalRewardPerSecond(uint256 _totalRewardPerSecond) external;

    function startTime() external view returns (uint256);

    function totalAllocPoint() external view returns (uint256);

    function totalRewardPerSecond() external view returns (uint256);

    function transferOwnership(address newOwner) external;

    function unfrozenDepositTime(uint256 _pid, address _account)
        external
        view
        returns (uint256);

    function updatePool(uint256 _pid) external;

    function userInfo(uint256, address)
        external
        view
        returns (uint256 amount, uint256 rewardDebt);

    function userLastDepositTime(uint256, address)
        external
        view
        returns (uint256);

    function withdraw(uint256 _pid, uint256 _amount) external;

    function withdrawAll(uint256 _pid) external;
}
