class User < ApplicationRecord
  acts_as_nested_set :counter_cache => :children_count # 启用嵌套集功能
  belongs_to :blog

  validates :name, presence: true

  Jimu_Apply_key = {relationship: "続柄", gender: "性別",sign_no: "保険証の記号", insured_no: "保険証の番号", kana_name: "申込者氏名（カナ）",
                    birth: "生年月日", email: "メールアドレス", join_time: "希望日"}

  scope :default_order, -> {order(id: :asc)}


  # paperclip 使用
  # medium 中号图片大小
  # thumb 小号图片大小
  # has_attached_file  参数介绍 https://www.rubydoc.info/gems/paperclip/Paperclip/ClassMethods
  #
  # has_attached_file :avatar, style: {medium: "300x300#", thumb: "100x100#"}, default_url: "/images/:style/missing.png"
  # # 4.0 之后 所以附件必须包括 content_type 验证。  默认情况下保持安全
  # validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  # validates :avatar, attachment_presence: true # 必填
  # validates_with AttachmentPresenceValidator, Properties: :avatar # 附件必须存在验证器
  # validates_with AttachmentSizeValidator, Properties: :avatar, less_than: 1.megabytes # 文件大小小于1兆


  # excel 形式 下载 user
  def self.excel_download users
    path = File.join(Rails.root,"test_file")
    FileUtils.mkdir_p path unless File.exists? path

    file = File.join(path, "#{SecureRandom.hex}.xlsx")


    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(name: "users") do |sheet|
        sheet.add_row ["First Column", "Second", "Third"]
        sheet.add_row [1, 2, 3]
      end


      p.serialize(file) # 写到文件里
    end


    pp file
  end


  # [{"relationship"=>""},
  #  {"gender"=>""},
  #  {"sign_no"=>""},
  #  {"insured_no"=>""},
  #  {"kana_name"=>""},
  #  {"birth"=>""},
  #  {"join_time"=>""}]
  # [{"customs_select"=>""},
  #  {"customs_multiple"=>""},
  #  {"customs_text"=>""},
  #  {"customs_address-postal"=>""},
  #  {"customs_address-state"=>""},
  #  {"customs_address-address"=>""},
  #  {"customs_address-site"=>""},
  #  {"customs_data"=>""},
  #  {"customs_phone"=>""},
  #  {"customs_test"=>""},
  #  {"customs_file_3"=>""},
  #  {"customs_test2"=>""},
  #  {"customs_test3"=>""},
  #  {"customs_test44"=>""},
  #  {"customs_select_1_1"=>""},
  #  {"customs_select_1_2"=>""},
  #  {"customs_file_test"=>""},
  #  {"customs_date_1"=>""},
  #  {"customs_one"=>""}]
  def self.test_roo
    excel = Roo::Excelx.new("C:/Users/GaoyaPC/Desktop/abc.xlsx") # 打开表格
    # pp excel.sheets  # 返回全部heet name

    # 遍历 每一张表， check 数据
    # excel.each_with_pagename do |name, sheet|
    #   pp sheet.row(1)
    # end

    # pp excel.sheet(0).row(1)  获取第一张表的第一行
    jimu_data = []
    row3 = [] # 或者 form 的key
    row2 = [] # 伸入者要根据 row_2 的name 去获取key
    jimu = []
    row_index = 0 # 记录当前行数
    not_index = [1,4,5]
    excel.sheet(0).each do |row|
      row_index += 1
      next if row_index == 1 || row_index == 4 || row_index == 5

      if row_index == 2
        row2 << row
      elsif row_index == 3
        row3 << row
      else

        jimu << row
      end
      # row[3].each_with_index do |val,index|
      #     jimu_val = val.present? ? val : row[2][index]
      #     jimu << {jimu_val => ""}
      # end
    end


   row2 = row2.flatten
   row3 = row3.flatten


    row3.each_with_index do |val, index|


      value = val.present? ? val : User::Jimu_Apply_key.invert[row2[index]].to_s
      jimu_data << {value => ""}
    end

    # TODO 判断 hash 是否一样 且 第二张表的 几个ID都是一样的就可以了
    # jimu_data 获取到的全部的key
    # jimu 获取到的全部的数据， 然后一列一列的取出来。 在验证就行了
    # TODO 注意的一点就是option 的处理


    # 全部的数据都取到了  简简单单解决了 验证的话 全部都使用前台的 参考前台代码。自己只需要取到数据，已经验证就行了
  end
end
