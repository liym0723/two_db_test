class ProductProperty < ApplicationRecord
  searchkick
  belongs_to :product
  belongs_to :property

end
