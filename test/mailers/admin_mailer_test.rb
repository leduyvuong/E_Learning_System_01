require "test_helper"

class AdminMailerTest < ActionMailer::TestCase
  test "statistic_mail" do
    mail = AdminMailer.statistic_mail
    assert_equal "Statistic mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
