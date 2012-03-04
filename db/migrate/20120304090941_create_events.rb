class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
    add_index :events, :user_id
  end
end
