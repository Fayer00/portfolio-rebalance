# app/models/stock_holding.rb
class StockHolding
  attr_reader :stock
  attr_accessor :quantity

  def initialize(stock, quantity)
    @stock = stock
    @quantity = quantity
  end

  # Compute the current market value for this holding
  def market_value
    @quantity * @stock.current_price
  end
end