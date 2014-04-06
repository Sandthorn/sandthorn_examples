class SandthornProductsController < ApplicationController

  before_action :log

  def new
    #@product = SandthornProduct.new
  end

  def index
    @products = SandthornProduct.all.select { |product| product.active == true }
  end

  def create
    @product = SandthornProduct.new product_params
    ap @product.aggregate_events
    puts @product.inspect
    if @product.save
      redirect_to "/sandthorn/product/#{@product.id}"
    else
      render 'new'
    end
  end

  def show
    @product = SandthornProduct.find(params[:id])
  end

  def edit
    @product = SandthornProduct.find params[:id]
  end

  def update
    @product = SandthornProduct.find(params[:id])
    puts @product.inspect
    @product.update_name product_params[:name]
    @product.update_price product_params[:price]
    @product.update_stock_status product_params[:stock_status]
    ap @product.aggregate_events
    puts @product.inspect
    @product.save

    redirect_to "/sandthorn/product/#{@product.id}"
  end

  def destroy
    @product = SandthornProduct.find(params[:id])
    @product.destroy
    ap @product.aggregate_events
    puts @product.inspect
    @product.save

    redirect_to "/sandthorn/products/index"
  end

  private
  def product_params
    params.require(:sandthorn_product).permit(:name, :price, :stock_status)
  end

  def log
    @event_log = []
    @aggregate_log = []

    SQLite3::Database.new( "db/development.sqlite3" ) do |db|
      db.execute( "select * from events" ) do |row|
        @event_log << row
      end

      db.execute( "select * from aggregates" ) do |row|
        @aggregate_log << row
      end
    end
  end
end
