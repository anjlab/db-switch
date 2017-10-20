module DbSwitch
  module ActiveRecordBase
    include DbSwitch::ThreadVariables

    def connect_to(connection_name)
      self.db_switch_connection_name = connection_name.to_s
      if ActiveRecord::Base.connection_handler.connected?(connection_name.to_s).nil?
        db_config =
          ActiveRecord::Base.configurations[connection_name.to_s] ||
          Rails.application.config.database_configuration[connection_name.to_s]

        if db_config && db_config[Rails.env.to_s]
          spec =
            if Rails::VERSION::MINOR.zero?
              resolver = ActiveRecord::ConnectionAdapters::ConnectionSpecification::Resolver.new(db_config)
              resolver.spec(Rails.env.to_sym, connection_name.to_s)
            else
              db_config[Rails.env.to_s].merge(name: connection_name.to_s)
            end
          ActiveRecord::Base.connection_handler.establish_connection spec
        else
          self.db_switch_connection_name = nil
        end
      end
      yield if block_given?
    ensure
      self.db_switch_connection_name = nil
    end

    def connection_specification_name
      db_switch_connection_name || super
    end
  end
end
