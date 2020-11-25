// Chriscoins ICO

// Version of compiler
pragma solidity ^0.4.11;

contract chriscoin_ico {
    
    // Introducing the maximum number of Chriscoins available for sale
    uint public max_chriscoins = 1000000;
    
    // Introducing the USD to Chriscoins conversion rate
    uint public usd_to_chriscoins = 500;
    
    // Introducing the total number of Chriscoins that have been bought by the investors
    uint public total_chriscoins_bought = 0;
    
    // Mapping from the investor address to its equity in Chriscoins and USD 
    mapping(address => uint) equity_chriscoins;
    mapping(address => uint) equity_usd;
    
    // Checking if an investor can buy Chriscoins
    modifier can_buy_chriscoins(uint usd_invested) {
        require (usd_invested * usd_to_chriscoins + total_chriscoins_bought <= max_chriscoins);
        _;
    }
    
    // Getting the equity in Chriscoins of an investor
    function equity_in_chriscoins(address investor) external constant returns (uint) {
        return equity_chriscoins[investor];
    }
    
    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }
    
    // Buying Chriscoins
    function buy_chriscoins(address investor, uint usd_invested) external 
    can_buy_chriscoins(usd_invested) {
        uint chriscoins_bought = usd_invested * usd_to_chriscoins;
        equity_chriscoins[investor] += chriscoins_bought;
        equity_usd[investor] = equity_chriscoins[investor] / 500;
        total_chriscoins_bought += chriscoins_bought;
    }
    
    // Selling Chriscoins
    function sell_chriscoins(address investor, uint chriscoins_sold) external {
        equity_chriscoins[investor] -= chriscoins_sold;
        equity_usd[investor] = equity_chriscoins[investor] / 500;
        total_chriscoins_bought -= chriscoins_sold;
    }
    
}