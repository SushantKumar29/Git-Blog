class AddTrackingToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :current_sign_in_at, :string
  	add_column :users, :last_sign_in_at, :string
  end
end
