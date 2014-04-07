class SandthornProduct
  include Sandthorn::AggregateRoot
  
  attr_reader :name, :price, :stock_status, :active

  INSTOCK = "instock"
  OUTOFSTOCK = "outofstock"
  DISCONTINUED = "discontinued"

  def initialize args = {}
    @name = args.fetch(:name, "")
    @price = args.fetch(:price, 0)
    @stock_status = args.fetch(:stock_status, INSTOCK)
    @active = true
  end

  def update_name new_name
    if name != new_name
      name_updated new_name
    end
  end

  def update_price new_price
    if price != new_price
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



  private

  def name_updated new_name
    @name = new_name
    commit
  end

  def price_updated new_price
    @price = new_price
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
end