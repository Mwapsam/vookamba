class AddUsernameToBusinesses < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :username, :string
  end
end
