class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks


  validates :name, :ticker, presence: true


  # our api key is stored in config/credentials.yml.enc file
  @@api_key = Rails.application.credentials.iex[:sandbox_api_key]


  def self.stock_exist(ticker_symbol)
    # where(ticker: ticker_symbol).first
    where(ticker: ticker_symbol).exists?
  end

  def self.new_lookup(ticker_symbol)  # self will allow us to calll without an instance

    client = IEX::Api::Client.new(
        publishable_token: @@api_key,
        endpoint: 'https://sandbox.iexapis.com/v1'
    )
    #client.price(ticker_symbol)  # return te price
    # create a new object that we will pass
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exeption
      return nil
    end
  end

  def new_lookup2(ticker_symbol)  # self will allow us to calll without an instance
    client = IEX::Api::Client.new(
        publishable_token: @@api_key,
        endpoint: 'https://sandbox.iexapis.com/v1'
    )
    client.price(ticker_symbol)  # return te price
  end




end
