class OrdersController < ApplicationController

  def index
    @order_destination = OrderDestination.new
  end

  def create
  end
end
