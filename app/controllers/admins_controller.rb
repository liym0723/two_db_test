class AdminsController < ApplicationController
  http_basic_authenticate_with name: "lym", password: "12345", except: :index

  def index
    # render plain: "text"    # plain 渲染普通文本。
    # render html: "<strong>加粗</strong>".html_safe # html 渲染文本
    # render status: 500 # 指定 status
    # request.variant = :show # 优先渲染的变种
    # render action: "show",locals: {name: "Liym", age: "18"} # locals 传递变量
    # render partial: "xxx" # 指定要渲染的局部模板

    # controller 里面渲染的属于完整的模板
    # view 渲染的是局部模板

    # 循环渲染单个 对象 or 渲染集合

    # xxx do {|x|  render partial: "ad", locals {ad : x} } 渲染单个对象
    # render partial: "ad", collection: @xxx  渲染集合 注: 尽量不要省略 :partial参数

    # js.erb 渲染有安全隐患。  所以渲染需要用 escape_javascript 处理


    # redirect_to
    # respond_to


  end

  def show
    # cache 缓存

    # 视图包含 2 种。 1, 传递过来的实例变量  2 本身的静态内容
    # cache key -> 路径 + 动态内容 cache key + 静态内容 cache key

    @a = User.first
  end
end
