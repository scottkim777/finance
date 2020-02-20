class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      #render json: stock
      if @stock
         #render 'users/my_portfolio'
          respond_to do |format|
            format.js {render layout: false} #{ render partial: 'users/stock_result'}
          end
      else
        respond_to do | format|
          flash.now[:alert] = "ERROR: #{params[:stock]} is not a valid symbol.  Please provide a valid symbol"
          format.js {render layout: false} #{ render partial: 'users/stock_result'}
        end
        #flash[:alert] = "ERROR: #{params[:stock]} is not a valid symbol.  Please provide a valid symbol"
        #redirect_to my_portfolio_path
      end
    else
      respond_to do | format|
        flash.now[:alert] = "ERROR: Empty symbol. Please provide a valid symbol"
        format.js {render layout: false} #{ render partial: 'users/stock_result'}
      end
      #flash[:alert] = "ERROR: Must enter stock symbol!!"
      #redirect_to my_portfolio_path
    end
    # puts “@@@ #{self.class.name}##{__callee__} sid=#{sid}”
    #puts "@@@@@@ #{self.class.name}##{__callee__} stock=#{stock}"

  end
end