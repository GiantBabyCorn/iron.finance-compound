// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./IIronSwap.sol";

interface IIron3usdFarm {
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
