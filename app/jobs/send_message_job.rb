class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    UserMailer.send_err_mail("a","b").deliver_now
  end
end
