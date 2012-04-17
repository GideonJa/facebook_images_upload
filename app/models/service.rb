class Service < ActiveRecord::Base
  serialize :metadata, Hash
  belongs_to :user
  belongs_to :provider
end
