class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_SENDER', 'sistema@blz.rivelinojunior.com')
  layout 'mailer'
end
