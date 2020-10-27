class SimpleFormTestController < ApplicationController

  def index

    # attr_accessor 生成 生成getter/setter方法实例 -> class 中
    # mattr_accessor 提供 getter/setter方法类 -> module 中
    # 2个实际上差不多，区别在 一个 class, 一个 module
    # mattr_accessor :hostname
    #  def self.hostname
    # @@hostname
    # end

    a = '<?begn?>P{"Header":{"DcdGuid":"00000024-afe7995c-ace5-46f9-8fc4-36ac9cd3f245","FunName":"getDevInterfaceConfInfo","Sid":"c180e246-0b36-4b70-a88b-e7e0934cbca8","Timestamp":"1603271010179"},"Status":{"Status":2,"Error_code":"4","Msg2Client":"Object non-existent: dcd guid invalid."}}<?endn?>'


    index = a.index("{")
    r_index =  a.rindex("}") - a.size


   pp JSON.parse(a[index..r_index])



  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.valid?
    render :new
  end

  def edit
    # 类（class）只不过是增加强了module，它比module多了三个方法：new()、allocate()和superclass()。
    @user = User.new
  end
  
  def update
    @user = User.new
    @user.valid?
    render :edit
  end


  def note
    # 记录下 gem 用的方法
    # hash.key?(:xxx) -> 判断hash是否存在对应的key
    # deep_merge -> 返回合并 hash. key重复 取后者
    # merge 合并hash
    # deep_dup TODO 不清楚
  end

end
