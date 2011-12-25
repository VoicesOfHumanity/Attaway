class CertificateRequestController < ApplicationController
  def new
    @certificate_request = CertificateRequest.new
  end

  def create
    @certificate_request = CertificateRequest.new(params[:certificate_request])
    if simple_captcha_valid?
      if @certificate_request.save
        if @certificate_request.receiver_email.blank?
          feedback_message = 'The certificate has been sent to your email address.'
          CertificateRequest.deliver(:send_certificate, @certificate_request)
        else
          feedback_message = 'The certificate has been sent to your email address for confirmation.'
          CertificateRequest.deliver(:send_confirmation, @certificate_request)
        end
        redirect_to(success_path, :notice => feedback_message)
      else
        if @certificate_request.duplicated?
          flash[:error] = "The certificate was not sent."
        else
          flash[:error] = "Invalid data prevented a successful submission."
        end
        render :new
      end
    else
      flash[:error] = "Invalid captcha - try again"
      render :new
    end
  end
end
