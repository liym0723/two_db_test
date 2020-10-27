class UsersController < ApplicationController
  before_action :check_authority
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :controller_helper
  # GET /users
  # GET /users.json
  def index
    # 可以根据设定的权限去显示对应的数据
    # user = policy_scope(User)
    # pp User.roots # 获取全部的根节点


    # AddLotsOfUsersJob.perform_later # 常规异步执行 -> 立即执行
    # set
    # wait -> 延迟多少时间来执行入队
    # wait_until -> 指定某个时间点入队
    # priority: 10 -> 入队这个job 并设定优先级
    # queue: :some_queue -> 入队到指定队列

    # 6个钩子，after, before,  around. 针对enqueue和perform
    # AddLotsOfUsersJob.set(wait: 20.second).perform_later# 指定延迟多久执行

    # SendMessageJob.perform_async(1,2,3)

  # Sidekiq 会把 perform_async 函数的参数保存在 Redis 中
    # perform是一个实例方法
    # HardWorker.perform_async('bob', 5)
    # 等价于上面 args -> 指参数
    # Sidekiq::Client.push('clss' => HardWorker, 'args' => ['bob',5])

    # 五分钟后执行的队列
    # HardWorker.perform_in(5.minutes, 'bob', 5)
    # HardWorker.perform_at(5.minutes.from_now, 'bob', 5)
    # 设置队列名字
    # HardWorker.set(queue: :critical).perform_async(name, count)
    # ApplicationMailer.seb
    @users = initialize_grid( User,order: 'id')

    # User.test_roo
 # pp Mustache.render("Hello {{plant}}",plant: "World!")

   # self.response_body = "hello word" # response_body 反应内容

   # render_to_body
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    # 验证 图片码
    if verify_rucaptcha?(@user) && @user.save
      respond_to do |format|
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mustache_test
    @users = User.all
    view = (UserMustache.new @users)
    # view.render  -> 模板里面的内容
    pp "=========================="
    pp self.response_body = view.render
  end


  # Excel 下载全部的数据
  def excel_download
    users = User.all
    redirect_to action: :index if users.blank?
    file_path = User.excel_download users


    redirect_to action: :index
  end


  def controller_helper
    " controller helper"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])


    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :parent_id)
    end

    # policy 返回的 current_user
    def pundit_user
      # TODO 因为没有current_user 默认给个用户吧
      User.find_by(id: 1)
    end

    def check_authority
      authorize :user
    end

end
