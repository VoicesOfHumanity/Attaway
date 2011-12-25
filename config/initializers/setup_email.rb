if false
  #-- Didn't seem to work. Figure out what this does?

ActionMailer::Base.delivery_method :sendmail

if Rails.env.development?
  class DevelopmentMailInterceptor
    def self.delivering_email(message)
      message.subject = "[#{message.to}] #{message.subject}"
      message.to      = "pablo@localhost"
    end
  end
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
end

end
