class AddServiceProviderToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :service_provider_id, :integer

  end
end
