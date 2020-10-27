class UserMailer < ApplicationMailer
  # 收不到邮件和配置有关系 用这个的送信人就能收到
  MAIL_FROM = "関東ITS健保 <noreply@as.its-kenpo.or.jp>"
  default from: MAIL_FROM


  def send_err_mail
    mail(to: '15079447645@163.com', subject: 'ITS APP Error [レストラン予約システム]') do |format|
      format.html {render inline: "11111111"}
    end
  end

  # UserMailer.send_mail.deliver_now
  def send_mail
    # subject 主题
    # from 发件人
    # to 收件人
    # cc 抄送
    # bcc 密送
    # reply_to 回邮地址
    # date 时间
    # attachments() 邮件中添加附近  TODO 发送不出去。。。
    file_path = File.join(Rails.root, "Gemfile.lock")

    mail(to: '15079447645@163.com', subject: "subject test",attachments: file_path ) do |format|
      format.text {"test text"}
    end


  end



end
