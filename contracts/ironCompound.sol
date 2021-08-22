// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "@openzeppelin/contracts/utils/Address.sol";

interface Decimals {
    function decimals() external view returns (uint8);
}

// import "contracts/interfaces/IUniswapV2Factory.sol";

interface IUniswapV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function migrator() external view returns (address);

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;

    function setMigrator(address) external;
}

// import "contracts/interfaces/IUniswapV2Router01.sol";

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
}

// import "contracts/interfaces/IIronSwap.sol";

interface IIronSwap {
    /// EVENTS
    event AddLiquidity(
        address indexed provider,
        uint256[] tokenAmounts,
        uint256[] fees,
        uint256 invariant,
        uint256 tokenSupply
    );

    event TokenExchange(
        address indexed buyer,
        uint256 soldId,
        uint256 tokensSold,
        uint256 boughtId,
        uint256 tokensBought
    );

    event RemoveLiquidity(
        address indexed provider,
        uint256[] tokenAmounts,
        uint256[] fees,
        uint256 tokenSupply
    );

    event RemoveLiquidityOne(
        address indexed provider,
        uint256 tokenIndex,
        uint256 tokenAmount,
        uint256 coinAmount
    );

    event RemoveLiquidityImbalance(
        address indexed provider,
        uint256[] tokenAmounts,
        uint256[] fees,
        uint256 invariant,
        uint256 tokenSupply
    );

    event RampA(
        uint256 oldA,
        uint256 newA,
        uint256 initialTime,
        uint256 futureTime
    );

    event StopRampA(uint256 A, uint256 timestamp);

    event NewFee(uint256 fee, uint256 adminFee, uint256 withdrawFee);

    event CollectProtocolFee(address token, uint256 amount);

    event FeeControllerChanged(address newController);

    event FeeDistributorChanged(address newController);

    // pool data view functions
    function getLpToken() external view returns (IERC20 lpToken);

    function getA() external view returns (uint256);

    function getAPrecise() external view returns (uint256);

    function getToken(uint8 index) external view returns (IERC20);

    function getTokens() external view returns (IERC20[] memory);

    function getTokenIndex(address tokenAddress) external view returns (uint8);

    function getTokenBalance(uint8 index) external view returns (uint256);

    function getTokenBalances() external view returns (uint256[] memory);

    function getNumberOfTokens() external view returns (uint256);

    function getVirtualPrice() external view returns (uint256);

    function calculateTokenAmount(uint256[] calldata amounts, bool deposit)
        external
        view
        returns (uint256);

    function calculateSwap(
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx
    ) external view returns (uint256);

    function calculateRemoveLiquidity(address account, uint256 amount)
        external
        view
        returns (uint256[] memory);

    function calculateRemoveLiquidityOneToken(
        address account,
        uint256 tokenAmount,
        uint8 tokenIndex
    ) external view returns (uint256 availableTokenAmount);

    function getAdminBalances()
        external
        view
        returns (uint256[] memory adminBalances);

    function getAdminBalance(uint8 index) external view returns (uint256);

    function calculateCurrentWithdrawFee(address account)
        external
        view
        returns (uint256);

    // state modifying functions
    function swap(
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx,
        uint256 minDy,
        uint256 deadline
    ) external returns (uint256);

    function addLiquidity(
        uint256[] calldata amounts,
        uint256 minToMint,
        uint256 deadline
    ) external returns (uint256);

    function removeLiquidity(
        uint256 amount,
        uint256[] calldata minAmounts,
        uint256 deadline
    ) external returns (uint256[] memory);

    function removeLiquidityOneToken(
        uint256 tokenAmount,
        uint8 tokenIndex,
        uint256 minAmount,
        uint256 deadline
    ) external returns (uint256);

    function removeLiquidityImbalance(
        uint256[] calldata amounts,
        uint256 maxBurnAmount,
        uint256 deadline
    ) external returns (uint256);

    function updateUserWithdrawFee(address recipient, uint256 transferAmount)
        external;

    function withdrawAdminFee() external;
}

// import "contracts/interfaces/IIronRoute.sol";

interface IIronRoute {
    function calculateSwapFromBase(
        IIronSwap pool,
        IIronSwap basePool,
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx
    ) external view returns (uint256);

    function calculateSwapToBase(
        IIronSwap pool,
        IIronSwap basePool,
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx
    ) external view returns (uint256);

    function swapFromBase(
        IIronSwap pool,
        IIronSwap basePool,
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx,
        uint256 minDy,
        uint256 deadline
    ) external returns (uint256);

    function swapToBase(
        IIronSwap pool,
        IIronSwap basePool,
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx,
        uint256 minDy,
        uint256 deadline
    ) external returns (uint256);
}

// import "contracts/interfaces/IIron3usdFarm.sol";

interface IIron3usdFarm {
    event Deposit(
        address indexed user,
        uint256 indexed pid,
        uint256 amount,
        address indexed to
    );
    event EmergencyWithdraw(
        address indexed user,
        uint256 indexed pid,
        uint256 amount,
        address indexed to
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
        address indexed rewarder,
        bool overwrite
    );
    event LogUpdatePool(
        uint256 indexed pid,
        uint256 lastRewardTime,
        uint256 lpSupply,
        uint256 accRewardPerShare
    );
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    event PoolFundChanged(address indexed fund);
    event Withdraw(
        address indexed user,
        uint256 indexed pid,
        uint256 amount,
        address indexed to
    );

    function add(
        uint256 allocPoint,
        address _lpToken,
        address _rewarder
    ) external;

    function deposit(
        uint256 pid,
        uint256 amount,
        address to
    ) external;

    function emergencyWithdraw(uint256 pid, address to) external;

    function fund() external view returns (address);

    function harvest(uint256 pid, address to) external;

    function harvestAllRewards(address to) external;

    function lpToken(uint256) external view returns (address);

    function massUpdatePools(uint256[] memory pids) external;

    function owner() external view returns (address);

    function pendingReward(uint256 _pid, address _user)
        external
        view
        returns (uint256 pending);

    function poolInfo(uint256)
        external
        view
        returns (
            uint256 accRewardPerShare,
            uint256 lastRewardTime,
            uint256 allocPoint
        );

    function poolLength() external view returns (uint256 pools);

    function renounceOwnership() external;

    function reward() external view returns (address);

    function rewardPerSecond() external view returns (uint256);

    function rewarder(uint256) external view returns (address);

    function set(
        uint256 _pid,
        uint256 _allocPoint,
        address _rewarder,
        bool overwrite
    ) external;

    function setFund(address _fund) external;

    function setRewardPerSecond(uint256 _rewardPerSecond) external;

    function totalAllocPoint() external view returns (uint256);

    function transferOwnership(address newOwner) external;

    function updatePool(uint256 pid)
        external
        returns (IronChef.PoolInfo memory pool);

    function userInfo(uint256, address)
        external
        view
        returns (uint256 amount, int256 rewardDebt);

    function withdraw(
        uint256 pid,
        uint256 amount,
        address to
    ) external;

    function withdrawAndHarvest(
        uint256 pid,
        uint256 amount,
        address to
    ) external;
}

interface IronChef {
    struct PoolInfo {
        uint256 accRewardPerShare;
        uint256 lastRewardTime;
        uint256 allocPoint;
    }
}

// import "contracts/interfaces/IFirebirdRoute.sol";

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

// import "contracts/interfaces/IFirebirdStakingPool.sol";

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

interface IFirebird3usdToken {
    function withdraw(uint256 _shares, uint256 _min_output_amount)
        external
        returns (uint256);
}

interface IDfynSwap {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] memory path,
        address to,
        uint256 deadline
    ) external;
}

contract IronCompound is Ownable {
    using SafeERC20 for IERC20;
    using Address for address;

    address internal constant iron3usdToken =
        0xb4d09ff3dA7f9e9A2BA029cb0A81A989fd7B8f17;
    address internal constant iceToken =
        0x4A81f8796e0c6Ad4877A51C86693B0dE8093F2ef;

    address internal constant iron3usdPool =
        0x837503e8A8753ae17fB8C8151B8e6f586defCb57;
    address internal constant iron3usdFarm =
        0x1fD1259Fa8CdC60c6E8C86cfA592CA1b8403DFaD;

    address internal constant firebirdRoute =
        0x8294B42C8acFF8e819064e8755a55D038060731E;
    address internal constant firebird3usdToken =
        0x32B7d3A9Ab9Ef0412e055C8C6538E9F929f58b38;
    address internal constant firebirdStakingPool =
        0xE9a8b6ea3e7431E6BefCa51258CB472Df2Dd21d4;
    address internal constant firebirdSwapRoute =
        0x7973b6961C8C5ca8026B9FB82332626e715ff8c7;

    address internal constant wMaticToken =
        0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270;
    address internal constant hopeToken =
        0xd78C475133731CD54daDCb430F7aAE4F03C1E660;

    address internal constant USDC = 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174;
    address internal constant WETH = 0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619;

    address internal constant dfynSwap =
        0xA102072A4C07F06EC3B4900FDC4C7B80b6c57429;
    address internal constant dfynWethToken =
        0x4c28f48448720e9000907BC2611F73022fdcE1fA;

    address internal constant quickswap =
        0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff;

    mapping(address => uint256) internal _userAlloc;
    uint256 internal _totalAlloc;
    uint256 internal _total3Usd;
    uint256 internal _allocRatio;

    mapping(address => bool) internal _isInWhiteList;

    constructor() {
        _allocRatio = getTokenUnit(iron3usdToken);
        addWhitelist(msg.sender);
    }

    function addWhitelist(address user) public onlyOwner {
        _isInWhiteList[user] = true;
    }

    modifier inWhiteList() {
        require(_isInWhiteList[msg.sender], "Not in whitelist");
        _;
    }

    function getTokenUnit(address token) public view returns (uint256) {
        return 10**Decimals(token).decimals();
    }

    function userInfo(address user)
        public
        view
        returns (
            uint256 alloc,
            uint256 amount,
            bool isInWhiteList
        )
    {
        alloc = _userAlloc[user];
        amount = (alloc * _total3Usd) / _totalAlloc;
        isInWhiteList = _isInWhiteList[user];
    }

    function deposite(uint256 amount) public returns (uint256) {
        require(amount > 0, "Fail: zero amount");
        compound();
        // updateAllocRatio();
        address sender = msg.sender;
        IERC20(iron3usdToken).safeTransferFrom(sender, address(this), amount);
        // calculate alloc of current user
        uint256 depositingAlloc = (amount * getTokenUnit(iron3usdToken)) /
            _allocRatio;
        // set deposited amount
        _total3Usd += amount;
        _userAlloc[sender] += depositingAlloc;
        _totalAlloc += depositingAlloc;

        // deposit to farm. pid: 0, the 3usd pool
        IIron3usdFarm(iron3usdFarm).deposit(0, amount, address(this));

        return depositingAlloc;
    }

    function withdraw(uint256 amount) public returns (uint256) {
        require(amount > 0, "Fail: zero amount");
        compound();
        // updateAllocRatio();
        address sender = msg.sender;
        uint256 share = (_userAlloc[sender] * _total3Usd) / _totalAlloc;
        require(amount <= share, "Fail: withdraw amount too much");
        (uint256 amountInFarm, ) = IIron3usdFarm(iron3usdFarm).userInfo(
            0,
            address(this)
        );
        uint256 amountToWithdraw;
        {
            amountToWithdraw = amount < amountInFarm ? amount : amountInFarm;
        }
        // pid: 0, the 3usd pool
        IIron3usdFarm(iron3usdFarm).withdrawAndHarvest(
            0,
            amountToWithdraw,
            address(this)
        );
        IERC20(iron3usdToken).safeTransfer(sender, amountToWithdraw);

        // calculate alloc
        {
            uint256 withdrawingAlloc = (amountToWithdraw *
                getTokenUnit(iron3usdToken)) / _allocRatio;
            _total3Usd -= amountToWithdraw;
            _userAlloc[sender] -= withdrawingAlloc;
            _totalAlloc -= withdrawingAlloc;
        }

        return amountToWithdraw;
    }

    function updateAllocRatio() internal returns (uint256) {
        // pid: 0, the 3usd pool
        (uint256 amountInFarm, ) = IIron3usdFarm(iron3usdFarm).userInfo(
            0,
            address(this)
        );
        uint256 current3usd = IERC20(iron3usdToken).balanceOf(address(this));
        _total3Usd = amountInFarm + current3usd;
        _allocRatio = (_total3Usd * getTokenUnit(iron3usdToken)) / _totalAlloc;

        return _allocRatio;
    }

    function compound() public returns (uint256) {
        if (_total3Usd == 0) {
            return 0;
        }
        uint256 current3usd = withdrawAndHarvest();
        uint256 currentFirebird3usd = depositToFirebird(current3usd);
        compoundFirebirdAndWithdraw(currentFirebird3usd);
        uint256 final3usd = swapRewardsAndAddLiquidity();
        require(final3usd > current3usd, "WTF: less 3usd");
        // update allocRatio
        _total3Usd = final3usd;
        _allocRatio = (final3usd * getTokenUnit(iron3usdToken)) / _totalAlloc;
        IERC20(iron3usdToken).approve(iron3usdFarm, final3usd);

        return final3usd;
    }

    function withdrawAndHarvest() internal returns (uint256) {
        // pid: 0, the 3usd pool
        (uint256 amount, ) = IIron3usdFarm(iron3usdFarm).userInfo(
            0,
            address(this)
        );
        // pid: 0, the 3usd pool
        IIron3usdFarm(iron3usdFarm).withdrawAndHarvest(
            0,
            amount,
            address(this)
        );
        uint256 current3usd = IERC20(iron3usdToken).balanceOf(address(this));
        require(current3usd >= _total3Usd, "WTF: less 3usd amount");
        if (current3usd > _total3Usd) {
            _total3Usd = current3usd;
        }

        return current3usd;
    }

    function depositToFirebird(uint256 amount) internal returns (uint256) {
        // deposit to firebird and mint firebird3usd
        IERC20(iron3usdToken).approve(firebirdRoute, amount);
        IFirebirdRoute(firebirdRoute).deposit(firebird3usdToken, amount, 1);
        uint256 currentFirebird3usd = IERC20(firebird3usdToken).balanceOf(
            address(this)
        );
        // deposit to staking pool
        IERC20(firebird3usdToken).approve(
            firebirdStakingPool,
            currentFirebird3usd
        );
        // pid: 37, iron 3usd pool
        IFirebirdStakingPool(firebirdStakingPool).deposit(
            37,
            currentFirebird3usd
        );

        return currentFirebird3usd;
    }

    function compoundFirebirdAndWithdraw(uint256 amount) internal {
        // compound
        IFirebirdRoute(firebirdRoute).harvestAllStrategies(firebird3usdToken);
        // withdraw from staking pool. pid: 37, iron 3usd pool
        IFirebirdStakingPool(firebirdStakingPool).withdraw(37, amount);
        // withdraw from firebird
        // IFirebird3usdToken(firebird3usdToken).withdraw(amount, 0);
        IFirebirdRoute(firebirdRoute).withdraw(firebird3usdToken, amount, 1);
    }

    function swapRewardsAndAddLiquidity() internal returns (uint256) {
        address[] memory path = new address[](2);
        uint256 deadline = block.timestamp + 100;

        // swap hope to wMatic
        {
            uint256 hopeBalance = IERC20(hopeToken).balanceOf(address(this));
            // at least one gwei
            if (hopeBalance > 1_000_000_000) {
                IERC20(hopeToken).approve(firebirdSwapRoute, hopeBalance);

                path[0] = hopeToken;
                path[1] = wMaticToken;

                IUniswapV2Router01(firebirdSwapRoute).swapExactTokensForTokens(
                    hopeBalance,
                    1,
                    path,
                    address(this),
                    deadline
                );
            }
        }

        // swap wMatic to usdc
        {
            uint256 wMaticBalance = IERC20(wMaticToken).balanceOf(
                address(this)
            );
            // at least one gwei
            if (wMaticBalance > 1_000_000_000) {
                IERC20(wMaticToken).approve(quickswap, wMaticBalance);

                path[0] = wMaticToken;
                path[1] = USDC;

                IUniswapV2Router01(quickswap).swapExactTokensForTokens(
                    wMaticBalance,
                    1,
                    path,
                    address(this),
                    deadline
                );
            }
        }

        // swap ice to usdc
        {
            uint256 iceBalance = IERC20(iceToken).balanceOf(address(this));
            // at least one gwei
            if (iceBalance > 1_000_000_000) {
                IERC20(wMaticToken).approve(quickswap, iceBalance);

                // path = new address[](3);
                path[0] = iceToken;
                path[1] = USDC;

                IDfynSwap(dfynSwap)
                    .swapExactTokensForETHSupportingFeeOnTransferTokens(
                        iceBalance,
                        1,
                        path,
                        address(this),
                        deadline
                    );
            }
        }
        {
            uint256 usdcBalance = IERC20(USDC).balanceOf(address(this));
            // at least one gwei
            if (usdcBalance > 1_000_000_000) {
                IERC20(USDC).approve(iron3usdPool, usdcBalance);

                // 0: USDC | 1: USDT | 2: DAI
                uint256[] memory minAmounts = new uint256[](3);
                // uint256[3] calldata minAmounts;
                minAmounts[0] = usdcBalance;
                minAmounts[1] = 0;
                minAmounts[2] = 0;

                IIronSwap(iron3usdPool).addLiquidity(
                    minAmounts,
                    1,
                    block.timestamp + 100
                );
            }
        }
        uint256 current3usd = IERC20(iron3usdToken).balanceOf(address(this));
        return current3usd;
    }
}
