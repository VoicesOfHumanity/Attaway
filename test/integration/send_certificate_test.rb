require 'test_helper'

class SendCertificateTest < ActionDispatch::IntegrationTest
  test "send certificate automatically" do
    visit('/')

    SampleData::AUTOMATIC_CERTIFICATE_REQUEST.each do |key, value|
      if key == "receiver_gender"
        select(value, :from => "certificate_request_#{key}")
      elsif key == "receiver_email"
        fill_in("certificate_request_#{key}", :with => "#{ActiveSupport::SecureRandom.hex(4)}@example.org")
      else
        fill_in("certificate_request_#{key}", :with => value)
      end
    end
    click_button('Request')
    assert page.has_content?('The certificate has been sent to your email address for confirmation.')
  end

  test "send certificate manually" do
    visit('/')
    SampleData::MANUAL_CERTIFICATE_REQUEST.each do |key, value|
      if key == "receiver_gender"
        select(value, :from => "certificate_request_#{key}")
      else
        fill_in("certificate_request_#{key}", :with => value)
      end
    end
    click_button('Request')
    assert page.has_content?('The certificate has been sent to your email address.')
  end
end
