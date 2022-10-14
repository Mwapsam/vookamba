class AddBusinessRefToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_reference :companies, :business, foreign_key: true
  end
end
