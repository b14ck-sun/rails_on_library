class CreateBorrows < ActiveRecord::Migration[5.2]
  def change
    create_table :borrows do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
