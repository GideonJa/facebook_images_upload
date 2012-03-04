class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :event

      t.timestamps
    end
    add_index :photos, :event_id
  end
end
