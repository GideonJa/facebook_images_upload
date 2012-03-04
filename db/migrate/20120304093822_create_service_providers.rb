class CreateServiceProviders < ActiveRecord::Migration
  def change
    create_table :service_providers do |t|
      t.string :name
      t.integer :order
      t.string :consumer_key
      t.string :consumer_secret

      t.timestamps
    end
  end
end
