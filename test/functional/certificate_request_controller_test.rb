require "test_helper"

class CertificateRequestControllerTest < ActionController::TestCase
  test "GET new" do
    get :new
    assert_instance_of CertificateRequest, assigns(:certificate_request)
    assert_response :success
    assert_template "certificate_request/new"
  end

  test "POST create with valid data" do
    data = SampleData::MANUAL_CERTIFICATE_REQUEST
    assert_difference("CertificateRequest.count") { post :create, :certificate_request => data }

    assert_equal var_data(:certificate_request), data
    assert_redirected_to success_path
    assert_equal "The certificate has been sent to your email address.", flash[:notice]
  end

  test "POST create with invalid data" do
    data = SampleData::MANUAL_CERTIFICATE_REQUEST.merge("sender_email" => nil)
    post :create, :certificate_request => data

    assert_equal var_data(:certificate_request), data
    assert_template "certificate_request/new"
    assert_equal "Invalid data prevented a successful submission.", flash[:error]
  end

  def var_data(name)
    assigns(name).attributes.except("id", "created_at", "updated_at", "confirmation_code")
  end
end
