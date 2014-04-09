# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
SandthornProductExample::Application.initialize!

if Rails.env.development?
  url = "sqlite://db/development.sqlite3"
else
  url = ENV["DATABASE_URL"]
end

catch_all_config = [ { driver: SandthornDriverSequel.driver_from_url(url: url) } ]
Sandthorn.configuration = catch_all_config
SandthornDriverSequel.migrate_db url: url