class UserMailer < ApplicationMailer
  # 收不到邮件和配置有关系 用这个的送信人就能收到
  # default from: %{'ITS Application Error' <its_sender@as.its-kenpo.or.jp>}


  def send_err_mail
    mail(to: '15079447645@163.com', subject: 'ITS APP Error [レストラン予約システム]') do |format|
      format.html {render inline: "11111111"}
    end
  end
end
