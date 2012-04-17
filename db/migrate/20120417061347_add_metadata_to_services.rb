class AddMetadataToServices < ActiveRecord::Migration
  def change
    add_column :services, :metadata, :text

  end
end
