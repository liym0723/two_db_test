class Library::Book < Library::ApplicationRecord
  self.table_name = 'books'

  belongs_to :user

end