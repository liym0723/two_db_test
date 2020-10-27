class TestDb2 < ActiveRecord::Migration[5.2]
  def change

  remove_index :users, [:name, :depth]  if index_exists?(:users, [:name,:depth])
    remove_index :users, [:name, :email]  if index_exists?(:users, [:name,:email])

  end
end
