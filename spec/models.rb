require 'active_record'

class User < ActiveRecord::Base
  validates :name, presence: true
end