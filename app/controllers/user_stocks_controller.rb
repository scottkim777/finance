class UserStocksController < ApplicationController
  def create


    if Stock.stock_exist(params[:ticker]) == false
      stock = Stock.new_lookup(params[:ticker])
      stock.save

      #@user_stock = UserStock.create(user: current_user, stock: stock)
      #flash[:notice] = "Stock #{stock.name} was added."
      #redirect_to my_portfolio_path
    else
      stock = Stock.find_by_ticker(params[:ticker])
      #@user_stock = UserStock.create(user: current_user, stock: stock)
      #redirect_to my_portfolio_path
    end

    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was added."
    redirect_to my_portfolio_path


  end

  def destroy
    stock = Stock.find(params[:id])
    # .first will return the object
    #user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock = UserStock.find_by(user_id: current_user.id, stock_id: stock.id)

    user_stock.destroy
    flash[:notice] = "#{stock.ticker} was deleted!"
    redirect_to my_portfolio_path

  end

end # class
