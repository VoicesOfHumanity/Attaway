class CertificateConfirmationController < ApplicationController
  CONFIRMATION_ERROR = "Your confirmation information is not valid".freeze

  def new
    if CertificateRequest.confirm?(params[:code])
      @code = params[:code]
    else
      flash[:error] = CONFIRMATION_ERROR
      redirect_to(root_path)
    end
  end

  def create
    @certificate_request = CertificateRequest.confirm?(params[:code])
    if @certificate_request
      CertificateRequest.deliver(:send_certificate, @certificate_request)

      # invalidate the current confirmation code
      @certificate_request.confirmation_code = nil
      @certificate_request.save

      redirect_to(success_path, :notice => 'Certificate sent successfully.')
    else
      flash[:error] = CONFIRMATION_ERROR
      redirect_to(root_path)
    end
  end
end
