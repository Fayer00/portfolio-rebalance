# app/models/portfolio.rb
class Portfolio
  attr_reader :holdings, :target_allocation

  # holdings: array of StockHolding
  # target_allocation: hash with stock tickers as keys and target weights as values (0.0..1.0)
  def initialize(holdings:, target_allocation:)
    @holdings = holdings
    @target_allocation = target_allocation
  end

  # Total portfolio value based on current market prices
  def total_value
    @holdings.sum(&:market_value)
  end

  # Current allocation as a hash { ticker => weight }
  def current_allocation
    total = total_value
    @holdings.map { |h| [h.stock.ticker, h.market_value / total] }.to_h
  end

  # Determine how much to buy/sell to match target allocation
  # Returns hash: { ticker => { action: :buy/:sell/:hold, shares: X, amount: $Y } }
  def rebalance
    total = total_value
    orders = {}

    @target_allocation.each do |ticker, target_weight|
      holding = @holdings.find { |h| h.stock.ticker == ticker }
      stock = holding&.stock || Stock.new(ticker)

      current_value = holding ? holding.market_value : 0.0
      target_value  = target_weight * total
      price = stock.current_price

      diff_value = target_value - current_value
      diff_shares = diff_value / price

      orders[ticker] = if diff_shares.abs < 0.01
                         { action: :hold, shares: 0, amount: 0.0 }
                       elsif diff_shares > 0
                         { action: :buy, shares: diff_shares.round(2), amount: diff_value.round(2) }
                       else
                         { action: :sell, shares: diff_shares.abs.round(2), amount: diff_value.abs.round(2) }
                       end
    end

    orders
  end
end