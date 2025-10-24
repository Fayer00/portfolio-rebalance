# app/models/stock.rb
class Stock
  attr_reader :ticker

  # Initialize stock with a ticker symbol (e.g., "AAPL")
  def initialize(ticker)
    @ticker = ticker
  end

  # Returns the latest available price.
  # In a real-world scenario, this might pull from a pricing API.
  def current_price
    # Mock data for illustration
    prices = {
      "AAPL" => 190.0,
      "META" => 320.0,
      "GOOG" => 140.0
    }
    prices[@ticker] || raise("No price data for #{@ticker}")
  end
end