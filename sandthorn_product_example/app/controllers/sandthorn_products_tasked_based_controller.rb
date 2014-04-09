class SandthornProductsTaskedBasedController < ApplicationController

  before_action :log
  skip_before_filter :verify_authenticity_token
  layout "false"

  def change_name
    product = SandthornProduct.find(params[:id])
    
    product.update_name params[:name]
    product.save
    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def change_price
    product = SandthornProduct.find(params[:id])
    product.update_price params[:price]
    product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def in_stock
    product = SandthornProduct.find(params[:id])
    product.in_stock
    product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def out_of_stock
    product = SandthornProduct.find(params[:id])
    product.out_of_stock
    product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def discontinue
    product = SandthornProduct.find(params[:id])
    product.discontinue
    product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def destroy
    product = SandthornProduct.find(params[:id])
    product.destroy
    product.save

    redirect_to "/sandthorn/products/index"
  end

  def put_on_sale
    product = SandthornProduct.find(params[:id])
    product.put_on_sale
    product.save

    respond_to do |format|
      format.json {render :json => {price: product.price, name: product.name}, status: 200 }
    end
  end

  def remove_from_sale
    product = SandthornProduct.find(params[:id])
    product.remove_from_sale
    product.save

    respond_to do |format|
      format.json {render :json => {price: product.price, name: product.name}, status: 200 }
    end
  end

  def get_log
    log_data = event_store_log
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
    log = event_store_log
    @event_log = log[:event_log]
    @aggregate_log = log[:aggregate_log]
  end

end
