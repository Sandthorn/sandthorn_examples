class ProductsController < ApplicationController

  before_action :log

  def new
    @product = Product.new
  end

  def index
    @products = Product.all
  end

  def create
    @product = Product.new product_params
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find(params[:id])
 
    if @product.update(params[:product].permit(:name, :price, :stock_status))
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
   
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :stock_status)
  end

  def log
    @log = []
    SQLite3::Database.new( "db/development.sqlite3" ) do |db|
      db.execute( "select * from products" ) do |row|
        @log << row 
      end
    end
  end

end
