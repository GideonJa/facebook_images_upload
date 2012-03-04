class Photo < ActiveRecord::Base
  belongs_to :event
  belongs_to :service_provider
  has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
