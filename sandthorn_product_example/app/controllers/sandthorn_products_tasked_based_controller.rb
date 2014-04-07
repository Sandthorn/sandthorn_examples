class SandthornProductsTaskedBasedController < ApplicationController

  before_action :log
  layout "false"

  # def new
  #   #@product = SandthornProduct.new
  # end

  # def index
  #   @products = SandthornProduct.all.select { |product| product.active == true }
  # end

  # def create
  #   @product = SandthornProduct.new product_params
  #   ap @product.aggregate_events
  #   if @product.save
  #     redirect_to "/sandthorn/product/#{@product.id}"
  #   else
  #     render 'new'
  #   end
  # end

  # def show
  #   @product = SandthornProduct.find(params[:id])
  # end

  # def edit
  #   @product = SandthornProduct.find params[:id]
  # end

  def change_name
    @product = SandthornProduct.find(params[:id])
    
    @product.update_name params[:name]
    @product.save
    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def change_price
    @product = SandthornProduct.find(params[:id])
    @product.update_price params[:price]
    @product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def in_stock
    @product = SandthornProduct.find(params[:id])
    @product.in_stock
    @product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def out_of_stock
    @product = SandthornProduct.find(params[:id])
    @product.out_of_stock
    @product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def discontinue
    @product = SandthornProduct.find(params[:id])
    @product.discontinue
    @product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def destroy
    @product = SandthornProduct.find(params[:id])
    @product.destroy
    ap @product.aggregate_events
    @product.save

    redirect_to "/sandthorn/products/index"
  end

  def get_log
    log_data = log
    test = render_to_string 'sandthorn_products/_log', layout: false
    respond_to do |format|
      format.html {render :text => test,  status: 200 }
    end
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

    {event_log: @event_log, aggregate_log: @aggregate_log}
  end
end
