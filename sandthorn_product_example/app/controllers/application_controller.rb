class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def event_store_log
    events = Sandthorn.get_events
    sql_raw_aggregates = "select aggregate_id, aggregate_type, aggregate_version from aggregates"
    sql_raw_snapshots = "select aggregate_id, aggregate_type, s.aggregate_version as snapshot_version, a.aggregate_version as current_version, snapshot_data from aggregates a, snapshots s where aggregate_table_id = a.id"
    aggregate_log = ActiveRecord::Base.connection.execute(sql_raw_aggregates)
    snapshots_log = ActiveRecord::Base.connection.execute(sql_raw_snapshots)
    {event_log: events, aggregate_log: aggregate_log, snapshots_log: snapshots_log}
  end

  def log
    log = event_store_log
    @event_log = log[:event_log]
    @aggregate_log = log[:aggregate_log]
    @snapshots_log = log[:snapshots_log]
  end
end
