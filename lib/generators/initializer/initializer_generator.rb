class InitializerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def copy_initializer_file
    # copy_file 文件复制到指定的目标路径， file_name 继承NamedBase 之后自动创建的
    copy_file "initializer.rb", "config/initializers/#{file_name}.rb"
  end
end


# class InitializerGenerator < Rails::Generators::Base
#   desc "This generator creates an initializer file at config/initializers"
#
#   def create_initializer_file
#     create_file "config/initializers/initializer.rb", "# 这里是初始化文件的内容"
#   end
# end

 # rails generate generator kaminari config