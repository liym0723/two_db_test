class NotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier_mailer.welcome.subject
  #

  # rails g mailer Notifier welcome  自动生成
  def welcome
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
