class AllProductsProjection < SandthornSequelProjection::Projection
  migration("20150305-1") do |db|
    db.create_table?(table_name) do
      primary_key :id
      String :aggregate_id, fixed: true, size: 36, null: false
      String :name

      index :aggregate_id, unique: true
    end
  end

  define_event_handlers do |h|
    h.define add_aggregate: { event: :new, type: SandthornProduct }
    h.define remove_aggregate: { event: :destroyed, type: SandthornProduct }
  end

  def add_aggregate(event)
    aggregate_id = event.aggregate_id
    name = event.new_values[:name]
    table.insert(aggregate_id: aggregate_id, name: name)
  end

  def remove_aggregate(event)
    aggregate_id = event.aggregate_id
    table.delete(aggregate_id: aggregate_id)
  end

  def table_name
    :all_products
  end

  def table
    db_connection[table_name]
  end
end