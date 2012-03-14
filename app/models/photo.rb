class Photo < ActiveRecord::Base
  serialize :metadata, Hash
  belongs_to :event
  belongs_to :service
  has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
