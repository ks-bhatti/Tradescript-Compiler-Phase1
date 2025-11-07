/* TradeScript Sample Test Program - Minimum 20 Lines
   This demonstrates a complete trading strategy in TradeScript
*/

strategy daily_rsi_trade {
    asset "AAPL";
    
    when (get_price("AAPL") < 150.50) {
        buy 100 shares of "AAPL";
        log "Purchased 100 shares at current price";
        stop_loss at 145.00;
        take_profit at 160.00;
    }
    otherwise {
        hold;
        log "Price too high, holding position";
    }
    
    monitor (portfolio.cash > 5000) {
        current_price = get_price("AAPL");
        trade_volume = get_volume("AAPL");
        
        when (trade_volume * current_price > 1000000) {
            sell 50 shares;
            log "Volume spike detected, selling shares";
        }
    }
}

strategy swing_trading {
    asset "MSFT";
    
    when (get_price("MSFT") > 300.25) {
        sell 25 shares of "MSFT";
        log "Swing trade executed";
        take_profit at 310.75;
        stop_loss at 295.00;
    }
}
