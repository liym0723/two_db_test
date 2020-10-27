class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  # extend  引入的都是类   -> Car.show

  # include  引入的都是实例  -> Car.new.show

  # def self.included(c) ... end  -> Car.show
  # 引入实例方法 也希望引入类方法

end
