class AddPackageRefToBusinesses < ActiveRecord::Migration[7.0]
  def change
    add_reference :businesses, :package, foreign_key: true
  end
end
