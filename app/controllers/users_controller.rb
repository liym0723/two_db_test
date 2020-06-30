class UsersController < ApplicationController
  before_action :check_authority
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    # 可以根据设定的权限去显示对应的数据
    # user = policy_scope(User)
    # pp User.roots # 获取全部的根节点

    @users = initialize_grid( User,order: 'id')

 # pp Mustache.render("Hello {{plant}}",plant: "World!")

   # self.response_body = "hello word" # response_body 反应内容
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

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
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
