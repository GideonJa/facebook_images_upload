class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :user
      t.references :service_provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.string :oauth_token_secret
      t.string :description

      t.timestamps
    end
    add_index :services, :user_id
    add_index :services, :service_provider_id
  end
end
