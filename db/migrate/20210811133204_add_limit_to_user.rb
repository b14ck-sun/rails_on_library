class AddLimitToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :limit, :integer
  end
end
