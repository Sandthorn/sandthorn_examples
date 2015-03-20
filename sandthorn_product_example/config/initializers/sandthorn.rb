if Rails.env.development?
  url = "sqlite://db/development.sqlite3"
else
  url = ENV["DATABASE_URL"]
end

Sandthorn.configure do |sand|
  sand.event_store = SandthornDriverSequel.driver_from_url(url: url)
end
SandthornDriverSequel.migrate_db url: url

SandthornSequelProjection.configure do |sand|
  sand.db_connection = Sequel.connect(url)
end
