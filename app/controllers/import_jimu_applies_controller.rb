class ImportJimuAppliesController < ApplicationController
  def index
    UserMailer.send_mail.deliver_now
  end
end
