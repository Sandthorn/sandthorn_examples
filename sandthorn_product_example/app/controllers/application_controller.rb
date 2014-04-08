class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def event_store_log
    
    sql_events = "select * from events order by sequence_number DESC"
    sql_aggrgates = "select * from aggregates"
    event_log = ActiveRecord::Base.connection.execute(sql_events)
    aggregate_log = ActiveRecord::Base.connection.execute(sql_aggrgates)
    
    {event_log: event_log, aggregate_log: aggregate_log}
  end

  def log
    log = event_store_log
    @event_log = log[:event_log]
    @aggregate_log = log[:aggregate_log]
  end
end
