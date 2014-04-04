class SandthornProduct
  include Sandthorn::AggregateRoot
  
  attr_reader :name, :price, :stock_status, :active

  def initialize args = {}
    @name = args.fetch(:name)
    @price = args.fetch(:price)
    @stock_status = args.fetch(:stock_status)
    @active = true
  end

  def update_name new_name
    puts "update_name #{name}, #{new_name} #{name == new_name}"
    if name != new_name
      @name = new_name
      name_updated
    end
  end

  def update_price new_price
    puts "update_price #{price}, #{new_price} #{price == new_price}"
    if price != new_price
      @price = new_price
      price_updated
    end
  end

  def update_stock_status new_stock_status
    puts "update_stock_status #{stock_status}, #{new_stock_status} #{stock_status == new_stock_status}"
    if stock_status != new_stock_status
      @stock_status = new_stock_status
      stock_status_updated
    end

  end

  def destroy
    if active
      @active = false
      deleted
    end
  end

  private

  def name_updated
    commit
  end

  def price_updated
    commit
  end

  def stock_status_updated
    commit
  end

  def deleted
    commit
  end
end