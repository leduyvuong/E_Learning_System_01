class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    AdminMailer.statistic_mail.deliver
  end
end
