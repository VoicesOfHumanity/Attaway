class UnsubscribeController < ApplicationController
  def new
    if CertificateRequest.confirm?(params[:code])
      @code   = params[:code]
      @target = params[:target]
    else
      flash[:error] = "Your code is not valid"
      redirect_to(root_path)
    end
  end

  def create
    @certificate_request = CertificateRequest.confirm?(params[:code])
    if @certificate_request
      Blacklist.add(@certificate_request.sender_email) if params[:target] == "s" # sender
      Blacklist.add(@certificate_request.receiver_email) if params[:target] == "r" # receiver

      # invalidate the current confirmation code
      @certificate_request.confirmation_code = nil
      @certificate_request.save!

      redirect_to(success_path, :notice => 'Address unsubscribed as requested.')
    else
      flash[:error] = "Your code is not valid"
      render :new
    end
  end

  # TODO: remove this when the admin interface is complete
  def kaput
    whitelist = %w/marcelo.delgado@gmail.com rogerweaton@gmail.com rogerweaton@eathlink.net/
    Blacklist.where(:email => whitelist).delete_all
    CertificateRequest.where('sender_email in (:emails) or receiver_email in (:emails)', :emails => whitelist).delete_all
    redirect_to(success_path, :notice => 'KAPUT!')
  end
end

