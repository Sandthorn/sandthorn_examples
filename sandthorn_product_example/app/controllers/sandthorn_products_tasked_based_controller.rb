class SandthornProductsTaskedBasedController < ApplicationController

  before_action :log
  skip_before_filter :verify_authenticity_token
  layout "false"

  def change_name
    product = SandthornProduct.find(params[:id])
    
    product.aggregate_trace trace_info do |p|
      p.update_name params[:name]
    end
    product.save
    
    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def change_price
    product = SandthornProduct.find(params[:id])
    product.aggregate_trace trace_info do |p|
      p.update_price params[:price]
    end
    product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def in_stock
    product = SandthornProduct.find(params[:id])
    product.aggregate_trace trace_info do |p|
      p.in_stock
    end
    product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def out_of_stock
    product = SandthornProduct.find(params[:id])
    product.aggregate_trace trace_info do |p|
      p.out_of_stock
    end
    product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def discontinue
    product = SandthornProduct.find(params[:id])
    product.aggregate_trace trace_info do |p|
      p.discontinue
    end
    product.save

    respond_to do |format|
      format.json {render :json => {}, status: 201 }
    end
  end

  def destroy
    product = SandthornProduct.find(params[:id])
    product.aggregate_trace trace_info do |p|
      p.destroy
    end
    product.save

    redirect_to "/sandthorn/products/index"
  end

  def put_on_sale
    product = SandthornProduct.find(params[:id])
    product.aggregate_trace trace_info do |p|
      p.put_on_sale
    end
    product.save

    respond_to do |format|
      format.json {render :json => {price: product.price, name: product.name}, status: 200 }
    end
  end

  def remove_from_sale
    product = SandthornProduct.find(params[:id])
    product.aggregate_trace trace_info do |p|
      p.remove_from_sale
    end
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

  def trace_info
    { ip: request.remote_ip }
  end

end
