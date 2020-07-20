class ApplicationJob < ActiveJob::Base
  # include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def expiration
    @expiration ||= 60 * 60 * 24 * 30 # 30 days
  end

end
