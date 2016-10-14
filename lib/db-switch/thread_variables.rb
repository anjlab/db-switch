module DbSwitch::ThreadVariables
  def db_switch_connection_name
    Thread.current[:db_switch_connection_name]
  end

  def db_switch_connection_name=(value)
    Thread.current[:db_switch_connection_name] = value
  end
  # attr_accessor :db_switch_connection_name # notice: this is not thread safe! (just for testing purposes)
end