class Notifications < ActionMailer::Base
  default :from => "URI Interfaith Star <noreply@attaway.info>"

  def send_confirmation(certificate_request)
    @certificate_request = certificate_request
    @confirmation_url = confirm_url(:code => @certificate_request.confirmation_code)
    @unsubscribe_url = unsubscribe_url(:code => @certificate_request.confirmation_code, :target => "s")
    attachments['certificate.pdf'] = CertificateBuilder.build(certificate_request)
    mail(
      :to      => "#{certificate_request.sender_name} <#{certificate_request.sender_email}>",
      :subject => "Certificate confirmation for #{certificate_request.receiver_name}"
    ) do |format|
      format.text { render :send_confirmation }
    end
  end

  def send_certificate(certificate_request)
    if certificate_request.receiver_email.blank? then
      send_certificate_to_sender(certificate_request)
    else
      send_certificate_to_receiver(certificate_request)
    end
  end

  def send_certificate_to_sender(certificate_request)
     @certificate_request = certificate_request
     @unsubscribe_url = unsubscribe_url(:code => @certificate_request.confirmation_code, :target => "s")
     attachments['certificate.pdf'] = CertificateBuilder.build(certificate_request)
     mail(
       :to      => "#{certificate_request.sender_name} <#{certificate_request.sender_email}>",
       :subject => "Certificate for #{certificate_request.receiver_name}"
     ) do |format|
       format.text { render :send_certificate_to_sender }
     end
  end

  def send_certificate_to_receiver(certificate_request)
    @certificate_request = certificate_request
    @unsubscribe_url = unsubscribe_url(:code => @certificate_request.confirmation_code, :target => "r")
    attachments['certificate.pdf'] = CertificateBuilder.build(certificate_request)
    mail(
      :to      => "#{certificate_request.receiver_name} <#{certificate_request.receiver_email}>",
      :subject => "Certificate from #{certificate_request.sender_name}"
    ) do |format|
      format.html { render :send_certificate_to_receiver }
    end
  end
end

