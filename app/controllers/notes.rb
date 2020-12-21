class Notes

  # 路由
  # http://localhost:3000/rails/info/routes
  # rails routes
  # 可以获取到 全部的路由


  # API
  # abs -> 绝对值
  # each -> 返回未修改的数组本身
  # map -> 返回修改后的拷贝数组   = collect
  # instance_methods(fasle) -> instance(实例), 实例方法， false 只获取非继承的方法
  # methods -> 全部类方法 能直接调用的
  # ActiveRecord 通过内省机制 会把类名Movie 映射到 movies的表中
  # Array#grep 返回枚举中每个包含模式的数组 (1..100).grep 38..44   #=> [38, 39, 40, 41, 42, 43, 44]
  # Module.nesting 获取当前代码所在的路径
  # Class.ancestors 获取当前类的祖先链
  # prepend 引入模块，优先级大于自己。
  # Module#define_method 动态定义方法，在myClass 内部执行， 定义为myClass的实例方法。
  # method_missing 当执行了找不到的方法的时候会进入这个方法，且抛出NoMethodError
  # ensure 不论begin执行了什么，最后都会执行
  # local_variables 查看当前作用域变量
  # class_eval 在一个已存在类的上下文执行一个块。 -> 用处: 在不知道类名字的情况下打开一个类
  # attr_reader 读
  # attr_writer 写
  # attr_accessor 读 和 写
  # in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil)

  # 拓展
  # rake db:migration:redo STEP=n

  # 理论
  # ruby class -> ||= ， 如果类不存在则创建，存在则是打开。
  # 一个对象的实例变量存在于 对象本身， 而一个对象的方法存在于对象自身的类中。 所以同一个类的对象 共享方法，不共享实例
  # gem 中 每个方法最外层都会用个 gem_name 的module来包裹，是为了不和其他人的类名发生冲突
  # 所有的类必然是Class, 而Class 属于自我引用
  # 祖先链包括模块，如果引入，这个模块会加入祖先链中。
  # 每次引入一个模块的时候，如果已经存在于祖先链中，则会忽然。 引入是从前往后
  # self 当前对象。 self.xx 从当前对象找。 xx 从头开始找
  # 私有方法不能明确接受者来调用
  # Kernel 是一个 module， 被Object 引入，实现了很多实例方法
  # obj.send(:my_menthod,3) = obj.my_menthod(3). send 可以调用私人方法
  # 为什么使用 send, 而不是. -> send 是不可变的,而字符串不是。 不变的用 symbol,
  # 代码块(block)，为了穿越作用域。 每当程序进入(或离开)类定义，模块定义，方法定义就会发送作用域切换。(class, module, def)
  # 局部变量在切换作用域的时候很容易失效。方法调用的时候不会
  # 嵌套文法作用域(扁平化作用域)，当一个变量需要传递到 class,甚至def里面。 class -> Class.new,  def -> define_method.
  # yield 调用代码块
  # proc。由快传唤来的对象，可以把快传递给 Proc.new, 使用 Proc#call 来执行代码块转换来的对象。 inc = Proc.new {|x| x + 1}, inc.call(2)
  # 1. proc.new{|x| x + 1}
  # 2. lambda{|x| x + 1}
  # 3. ->(x) { x + 1 } = lamdba{|x| x + 1}
  # 参数中 &xxx -> 告诉这是一个Proc对象，我想把它当成代码块来使用
  # $ -> 把参数转换成代码块，再把代码块传递给这个方法
  # lambda 是 proc的变种

  # lambda vs proc
  # return, lambda   从当前块里面返回.. proc  从定义块的作用域中返回
  # 参数 lambda 抛出 ArgumentError错误, proc 则会把传递的参数调整成自己期望的形式 (a,b) -> (1,2,3) [1,2] -- (1) [1,nil]
  # 总结: lambda 更直观 像一个方法， return也只是从块中返回不会结束代码。常用

  # include, 类包含一个模块后，模块的方法通常会变成类的实例方法
  # include 中 self.included(base); base.extend xxx  。 xxx 会变成类方法   TODO base 是当前的对象， extend的方法会变成当前对象的类方法

  # extend ActiveSupport::Concern
  #



  # #=> 返回值
  # MyClass.my_method -> 类方法
  # MyClass::MY_CONSTANT -> 常量
  # MyClass#my_method -> 实例方法
  # #MySingletonClass -> 单件类


  def initialize(text)
    @text = text
  end

  # 对象内的方法 存在于 对象本身
  def welcome
    @text
  end

  def ltest li
    pp li
  end

end

n = Notes.new("liym")
pp n.class
pp Notes.instance_methods(false)
pp n.instance_variables

pp n.methods.grep(/we/) # 获取we开头的实例方法

# pp Notes.instance_methods
pp Notes.superclass # => Object
pp Object.superclass # => BasecObject
pp BasicObject.superclass # => nil
pp Module.superclass #=> Object
pp Object.class #=> Class
pp Class.class #=> Class

# Module 模块, Class 类
# Module -> 适合被包含到别的代码中
# Class -> 适合被实例化或被继承
pp Class.superclass # => Module  class 的父类就是 Module,比Module 稍微多了几个方法(new, allocate, superclass)

module MyModule
  MyText = "out liym"
  class MyClass
    MyText = "inn liym"
    # Module.nesting # [MyModule::MyClass, MyModule]
  end
end
# :: 在前面表示路径的根位置, 也就是 绝对路径
pp MyModule::MyText
pp MyModule::MyClass::MyText

pp self

module LiymTest
  # 细化 必须在  refine 中.
  # 使用 using 引入模块，加载细化，进行局部的修改
  # TODO 如果在其他方法中调用覆盖的方法 是无法覆盖的
  refine String do
    def reverse
      'ESREVER'
    end
  end
end

module StringStuff
  using LiymTest # 引入细化，引入重写的方法
  pp "xxe".reverse # -> "ESREVER"
end

pp "xxe".reverse # -> exx

pp Notes.ancestors

# grep 传递一个块，对每个正则表达式匹配的元素 这个快都会被执行。 匹配括号中正则表达式的字符串会存放在全局变量$1 里.
n.methods.grep(/^welco(.*)/){ n.ltest $1}

pp local_variables


c = Notes.new("liym")
cc = c.method :welcome
pp cc.class
pp cc.call

def add_metho_to(a_class)
  # 打开 c_class 类 执行一个块
  a_class.class_eval do
    def m; 'hello'; end
  end
end

add_metho_to String
pp "m".m

class String
  # 别名 alias_method :new_name, :old_name.
  # 从一个重新定义的方法中调用原始的 被重命名的版本
  alias_method :old_reverse,:reverse

  def reverse
    "x#{old_reverse}x"
  end
end

pp "abc".reverse