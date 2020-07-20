class BlogsController < ApplicationController

  # 树的显示
  def index
    UserMailer.send_err_mail.deliver_now

    blogs = Blog.all
    if blogs.blank?
      root1 = Blog.create(name: '1', content: '跟节点1')
      son_1 = root1.children.create(name: '1.1', content: '1的子节点' )
      grandson_1 = son_1.children.create(name: '1.1.1',content: '1.1的子节点,1的孙节点')
      son_2 = root1.children.create(name: '1.2', content: '1的子节点' )
      grandson_1 = son_2.children.create(name: '1.2.1',content: '1.2的子节点,1的孙节点')

      root2 = Blog.create(name: '2', content: '跟节点2')
      root2.children.create(name: '2.1', content: '2的子节点' )
      root2.children.create(name: '2.2', content: '2的子节点' )
      root2.children.create(name: '2.3', content: '2的子节点' )
    end
    # Blog.tree_view(:name)

    return if request.get?
    pp params
    blog = Blog.where(id: params[:blog_id]).first
    pp @options = blog.children.pluck(:name, :id)
  end



end