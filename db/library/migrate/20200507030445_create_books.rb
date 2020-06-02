class CreateBooks < ActiveRecord::Migration[5.2]

  #id_checks的每一个migrate文件都要重写这个connection方法
  def connection
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Library::connection_name]).connection
  end

  def change
    create_table :books, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      #   t.integer :in_stock, null: false, default: 1


      t.timestamps
    end
  end
end
