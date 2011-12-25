class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimpleCaptcha::ControllerHelpers

  before_filter do
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
