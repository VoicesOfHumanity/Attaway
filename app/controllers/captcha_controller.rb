class CaptchaController < ApplicationController
  def new
    render :partial => 'simple_captcha/reload_captcha'
  end
end
