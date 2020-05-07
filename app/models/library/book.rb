class Library::Book < Library::ApplicationRecord
  self.table_name = 'books'

  belongs_to :user


  validates :name, :user_id ,presence: true
end