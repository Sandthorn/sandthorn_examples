module Sandthorn
  class ProductsController < ApplicationController

    before_action :log
    skip_before_filter :verify_authenticity_token

    def new
      #@product = SandthornProduct.new
    end

    def index
      @products = SandthornProduct.all.select { |product| product.active == true }
    end

    def create
      SandthornProduct.aggregate_trace trace_info do
        @product = SandthornProduct.new product_params
      end
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

      @product.aggregate_trace trace_info do |aggregate|

        aggregate.update_name product_params[:name]
        aggregate.update_price product_params[:price]
        puts aggregate.stock_status
        puts product_params[:stock_status]
        aggregate.update_stock_status product_params[:stock_status]
        puts aggregate.stock_status
        aggregate.put_on_sale if product_params[:on_sale] == "true"
        aggregate.remove_from_sale if product_params[:on_sale] == "false"

      end
      @product.save

      redirect_to sandthorn_product_path(@product.id)
    end

    def destroy
      @product = SandthornProduct.find(params[:id])
      @product.destroy
      @product.save

      redirect_to "/sandthorn/products/index"
    end

    private
    def product_params
      params.require(:sandthorn_product).permit(:name, :price, :stock_status, :on_sale)
    end

    def trace_info
      trace_info = {ip: request.remote_ip}
    end

  end

end