class ApplicationMailer < ActionMailer::Base
  default from: "BLZ Life <#{ENV.fetch('MAILER_SENDER')}>"
  layout 'mailer'
end
