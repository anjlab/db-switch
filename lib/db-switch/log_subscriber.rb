module DbSwitch
  module LogSubscriber
    include DbSwitch::ThreadVariables

    attr_accessor :color_value

    def colorize_payload_name(name, payload_name)
      if db_switch_connection_name
        self.color_value =
          if payload_name.blank? || payload_name == 'SQL'
            :MAGENTA
          else
            :CYAN
          end
      end
      super
    end

    def debug(msg)
      msg = color("[#{db_switch_connection_name}]", color_value || :CYAN, true) + msg if db_switch_connection_name
      super(msg)
    end
  end
end
