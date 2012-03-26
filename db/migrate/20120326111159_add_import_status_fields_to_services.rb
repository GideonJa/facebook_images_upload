class AddImportStatusFieldsToServices < ActiveRecord::Migration
  def change
    add_column :services, :import_started_at, :datetime

    add_column :services, :import_ended_at, :datetime

    add_column :services, :import_total_photos, :integer

    add_column :services, :import_num_photos, :integer

  end
end
