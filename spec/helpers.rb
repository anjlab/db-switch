module Helpers
  module_function

  def self.create_database(name)
    # re-create database
    ActiveRecord::Base.establish_connection(adapter: 'postgresql', database: 'postgres')
    ActiveRecord::Base.connection.execute "DROP DATABASE IF EXISTS #{name}"
    ActiveRecord::Base.connection.execute "CREATE DATABASE #{name};"
    ActiveRecord::Base.remove_connection

    # load tables
    using_db(name) do
      load('schema.rb')
    end
  end

  def self.clear_database(name)
    using_db(name) do
      User.delete_all
    end
  end

  def self.using_db(name)
    if block_given?
      ActiveRecord::Base.establish_connection(adapter: 'postgresql', database: name)
      yield
      ActiveRecord::Base.remove_connection
    end
  end
end