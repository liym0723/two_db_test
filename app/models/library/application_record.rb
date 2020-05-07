class Library::ApplicationRecord < ActiveRecord::Base

  # Returns whether this class is an abstract class or not.
  self.abstract_class = true

  # The prefix string to prepend to every table name.
  def self.table_name_prefix
    database_name = self.configurations[Library::connection_name]['database']
     "#{database_name}."
  end

  # establish_connection 连接数据库
  establish_connection self.configurations[Library::connection_name]
end