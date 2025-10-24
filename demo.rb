aapl = Stock.new("AAPL")
meta = Stock.new("META")

holdings = [
  StockHolding.new(aapl, 10),  # 10 shares of AAPL
  StockHolding.new(meta, 3)    # 3 shares of META
]

target_alloc = {
  "AAPL" => 0.6,
  "META" => 0.4
}

portfolio = Portfolio.new(holdings: holdings, target_allocation: target_alloc)

puts "Total Value: $#{portfolio.total_value.round(2)}"
puts "Current Allocation: #{portfolio.current_allocation}"
puts "Rebalance Orders: #{portfolio.rebalance}"