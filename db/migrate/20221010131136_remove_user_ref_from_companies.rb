class RemoveUserRefFromCompanies < ActiveRecord::Migration[7.0]
  def change
    remove_reference :companies, :user, null: false, foreign_key: true
  end
end
