require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  Notifications.default_url_options[:host] = "localhost:3000"

  test "send certificate to receiver" do
    cr   = CertificateRequest.new(SampleData::AUTOMATIC_CERTIFICATE_REQUEST_WITH_TIMESTAMPS)
    mail = Notifications.send_certificate(cr)

    assert_equal 1, mail.attachments.size
    assert_equal 'certificate.pdf', mail.attachments.first.filename
    assert_equal  'application/pdf; filename=certificate.pdf', mail.attachments.first.content_type
    assert_equal "Certificate from #{cr.sender_name}", mail.subject
    assert_equal [cr.receiver_email], mail.to
  end

  test "send certificate to sender" do
    cr   = CertificateRequest.new(SampleData::MANUAL_CERTIFICATE_REQUEST_WITH_TIMESTAMPS)
    mail = Notifications.send_certificate(cr)

    assert_equal 1, mail.attachments.size
    assert_equal 'certificate.pdf', mail.attachments.first.filename
    assert_equal 'application/pdf; filename=certificate.pdf', mail.attachments.first.content_type
    assert_equal "Certificate for #{cr.receiver_name}", mail.subject
    assert_equal [cr.sender_email], mail.to
  end

  test "send confirmation" do
    cr   = CertificateRequest.new(SampleData::MANUAL_CERTIFICATE_REQUEST_WITH_TIMESTAMPS)
    mail = Notifications.send_confirmation(cr)

    assert_equal 1, mail.attachments.size
    assert_equal "Certificate confirmation for #{cr.receiver_name}", mail.subject
    assert_equal [cr.sender_email], mail.to
  end
end

