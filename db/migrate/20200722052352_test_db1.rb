class TestDb1 < ActiveRecord::Migration[5.2]
  def change
    add_index :users, [:name, :depth]

    add_index :users, [:name, :email], name: "liym_test"
  end
end
