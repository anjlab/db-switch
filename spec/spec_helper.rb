ENV['RAILS_ENV'] ||= 'test'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'db-switch'

$LOAD_PATH.unshift File.expand_path('../spec', __FILE__)

# Init DB schema and models
require 'helpers'
require 'models'

DATABASES = %w[db_switch_test_db1 db_switch_test_db2].freeze
DATABASES.each { |db| Helpers.create_database(db) }

require 'active_record/railtie'

# Define the application and configuration
module Config
  class Application < ::Rails::Application
    config.eager_load = false
    config.root = File.expand_path('../app', __FILE__)
  end
end

# Initialize the application
Config::Application.initialize!

# configure RSpec
RSpec.configure do |config|
  config.include Helpers

  config.before(:each) do
    DATABASES.each { |db| Helpers.clear_database(db) }

    ActiveRecord::Base.establish_connection(:test)
  end
end
