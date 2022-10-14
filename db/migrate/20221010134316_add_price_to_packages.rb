class AddPriceToPackages < ActiveRecord::Migration[7.0]
  def change
    add_column :packages, :price, :integer
  end
end
