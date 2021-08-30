class AdminMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.statistic_mail.subject
  #
  def statistic_mail
    @users = User.statistics_month(Date.today.strftime("%m"))
    make_bootstrap_mail(
      to: "firesoul0608@gmail.com",
      from: "firesoul060p@gmail.com",
      subject: "Báo cáo ngày #{Date.today.strftime("%d/%m/%Y")}",
    )
  end
end
