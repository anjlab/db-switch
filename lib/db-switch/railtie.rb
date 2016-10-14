require 'db-switch/thread_variables'
require 'db-switch/active_record_base'
require 'db-switch/log_subscriber'

require 'rails'

module DbSwitch
  class Railtie < ::Rails::Railtie
    initializer 'db-switch->active_record' do
      ActiveSupport.on_load(:active_record) do
        # extend AR functionality
        ActiveRecord::Base.send(:extend, DbSwitch::ActiveRecordBase)
        # extend SQL query logger
        ActiveRecord::LogSubscriber.send(:prepend, DbSwitch::LogSubscriber)
      end
    end
  end
end