class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def event_store_log
    event_log = []
    aggregate_log = []

    SQLite3::Database.new( "db/development.sqlite3" ) do |db|
      db.execute( "select * from events order by sequence_number DESC" ) do |row|
        event_log << row
      end

      db.execute( "select * from aggregates" ) do |row|
        aggregate_log << row
      end
    end

    {event_log: event_log, aggregate_log: aggregate_log}
  end

  def log
    log = event_store_log
    @event_log = log[:event_log]
    @aggregate_log = log[:aggregate_log]
  end
end
