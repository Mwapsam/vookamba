class RemoveBusinessIdFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_reference :messages, :business, null: false, foreign_key: true
  end
end
