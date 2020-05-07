class AddColumnToJiues < ActiveRecord::Migration[5.2]
  def change
    add_column :jimus,:user_id,:integer
  end
end
