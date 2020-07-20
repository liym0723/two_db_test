class UserMustache < MustacheBase
  # "self.path E:/lym_project/two_db_test/app/mustaches"
  self.path = File.dirname(__FILE__)
  UserStruct = Struct.new(:name,:email)

  def initialize(users,options = {})
    pp "1111111111111"
    pp @options = options
    @users = users
    # @users = []
    # users.each do |user|
    #   @users << UserStruct.new(user.name,user.email)
    # end

    @calls = 0
    @cached = nil
    initialize_settings
  end

  def repo
    # pp @users
    repo = []
    @users.each {|user| repo << user.attributes}
    repo
  end


  def name
    "Liym6666666"
  end

  def value
    10_000
  end

  def taxed_value
    value - (value * 0.4)
  end

  def in_ca
    true
  end

  def html_value
    "<a href='baid'>Test Html</a>"
  end


  # TODO 没跑出来
  def wrapped
    {
        "planet": "World",
        "lambda": function() { return "{{planet}}" }
    }
  end

  def person
    {
        "person?": { "name": "Jon" }
    }
  end


  def in_present
    false
  end



  def rendered
    lambda{|text| "<h1>#{text}</h1>"}
  end

  def not_rendered
    lambda { |text| "{{= | =}}#{text}" }
  end

  def change_tag
    "test change tag"
  end
end