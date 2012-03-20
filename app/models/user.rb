class User < ActiveRecord::Base
  has_many :events
  has_many :services
  has_many :photos
end
