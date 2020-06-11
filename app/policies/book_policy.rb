class BookPolicy < ApplicationPolicy
  # 根据controller 方法 动态去创建
  # action_methods 获取全部的 action方法。
  # define_method 动态创建方法
  UsersController.action_methods.each do |action_name|
    define_method "#{action_name}?" do
      user.name == "liym"
    end
  end



  class Scope < Scope
    def resolve
      if user.name == "liym_2"
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
