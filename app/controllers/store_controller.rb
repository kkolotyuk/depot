class StoreController < ApplicationController
  def index
    if !session[:counter]
      session[:counter] = 1
    else
      session[:counter] += 1
    end
    @products = Product.order(:title)
  end
end
