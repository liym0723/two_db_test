class KaminariTestsController < ApplicationController

  # 1. 源码文件结构分析，了解每一个文件夹内文件的用途  -> 0.7天
      # lib 核心， 主文件
      # readme.md -> gem 文档
      # gemspec 配置文件
      # lib gem name.rb -> 配置 以及 初始化代码， 实现在lib 的其他文件下

  # 2. 分析源码什么时候加载进项目，在哪里加载的  -> 0.7天


  # 3. 列出项目中常用的方法，从源码中找出这些方法的定义，分析方法怎么实现的 -> 1.6 天

  # 4. 自己写一个简化版本gem，实现第3步列出的方法 -> 2天


  # ruby gem 是一个复用的 打包好的 ruby 应用程序 或者 类库



  def index
#   [1,2,3].page(params[:page]).per(2)
    # def per -> 返回的是 limit(n), limit(n).offset(n) 相当于一个scope
    # page 提供了一个 limit().offset
    # per 也提供了一个 limit().offset 2者会起冲突，用后者
    @users = User.all.test_page(params[:test_page])
    # @users = User.all.page(1)
    # $LOAD_PATH 加载的全部 路径
    # pp $LOAD_PATH
    #pp $LOAD_PATH.size

  end

  def step_1
=begin
  gem_name.gemspec -> 配置一些 gem 包的版本，发送 等设置

  lib
     xxx.rb

 extend  -> 类方法
 includes -> 实例方法
 require ->载入一个库 会阻止多次载入。 实例方法


 module vs class
  class = 增强的 module . class 多了三个方法 new(), allocate(), superclass()

  include 包含一个 module 时，把他的实例方法和变量 变成了 class的实例方法 和变量。 祖先连会出现 这个 module
  extend 扩展一个 module时， 把实例方法和类加入到 class 祖先链不会出现 这个 module


 defined? 是否定义了 变量

 freeze  将一个Ruby对象冻结起来防止其被意外更改。




  gem 命名
  ruby_parser -> require 'ruby_parser' -> RubyParser
  ruby-parser -> require 'ruby/parser' -> Ruby::Parser
  net-http-digest_auth -> require 'net/http/digest_auth' -> Net::HTTP::DigestAuth
  TODO 不能使用大写字母


  readme.md -> gem 文档。
  gemspec ->
=end
end


def step_2
end

def step_3
end

def step_4
end

end
