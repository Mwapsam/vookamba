class AddCategoryRefToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_reference :companies, :category, foreign_key: true
  end
end
