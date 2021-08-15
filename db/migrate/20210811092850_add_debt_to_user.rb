class AddDebtToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :debt, :integer, :default => 0
  end
end
