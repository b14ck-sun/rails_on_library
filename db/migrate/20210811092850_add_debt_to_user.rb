class AddDebtToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :Debt, :integer
  end
end
