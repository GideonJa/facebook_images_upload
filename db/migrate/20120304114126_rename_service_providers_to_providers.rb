class RenameServiceProvidersToProviders < ActiveRecord::Migration
  def up
    rename_table :service_providers, :providers
    rename_column :photos, :service_provider_id, :service_id
    rename_column :services, :service_provider_id, :provider_id
  end

  def down
    rename_table :providers, :service_providers
    rename_column :photos, :service_id, :service_provider_id
    rename_column :services, :provider_id, :service_provider_id
  end
end
