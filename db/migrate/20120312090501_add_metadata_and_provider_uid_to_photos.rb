class AddMetadataAndProviderUidToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :metadata, :text
    add_column :photos, :provider_uid, :string
    add_index :photos, [:service_id, :provider_uid]
  end
end
