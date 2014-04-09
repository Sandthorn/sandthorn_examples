class SandthornProduct
  include Sandthorn::AggregateRoot
  
  attr_reader :name, :price, :stock_status, :active, :on_sale

  INSTOCK = "instock"
  OUTOFSTOCK = "outofstock"
  DISCONTINUED = "discontinued"

  def initialize args = {}
    @name = args.fetch(:name, "")
    @price = args.fetch(:price, 0).to_i
    @stock_status = args.fetch(:stock_status, INSTOCK)
    @active = true
    @on_sale = false
  end

  def update_name new_name
    if name != new_name
      name_updated new_name
    end
  end

  def update_price new_price
    if price != new_price.to_i
      price_updated new_price
    end
  end

  def update_stock_status new_stock_status
    if stock_status != new_stock_status
      stock_status_updated new_stock_status
    end

  end

  def in_stock
    unless stock_status == INSTOCK
      product_in_stock
    end
  end

  def out_of_stock
    unless stock_status == OUTOFSTOCK
      product_out_of_stock
    end
  end

  def discontinue
    unless stock_status == DISCONTINUED
      product_discontinued
    end
  end

  def destroy
    if active
      destroyed
    end
  end

  def restore
    unless active
      restored
    end
  end

  def put_on_sale
    unless on_sale
      product_on_sale
    end
  end

  def remove_from_sale
    if on_sale
      removed_from_sale
    end
  end

  private

  def name_updated new_name
    @name = new_name
    commit
  end

  def price_updated new_price
    @price = new_price.to_i
    commit
  end

  def stock_status_updated new_stock_status
    @stock_status = new_stock_status
    commit
  end

  def destroyed
    @active = false
    commit
  end

  def restored
    @active = true
    commit
  end

  def product_in_stock
    @stock_status = INSTOCK
    commit
  end

  def product_out_of_stock
    @stock_status = OUTOFSTOCK
    commit
  end

  def product_discontinued
    @stock_status = DISCONTINUED
    commit
  end

  def product_on_sale
    @on_sale = true
    @price = (price*0.8).to_i
    @name = "ON SALE!!!! #{name}"
    commit
  end

  def removed_from_sale
    @on_sale = false
    @price = (price*1.25).to_i
    @name.slice! "ON SALE!!!! "
    commit
  end

end