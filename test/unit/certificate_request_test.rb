require 'test_helper'

class CertificateRequestTest < ActiveSupport::TestCase
  [:sender_name, :sender_email, :receiver_name].each do |attribute|
    test "#{attribute} should be required" do
      assert_invalid_values(attribute, "", nil)
    end
  end

  [:sender_name, :receiver_name].each do |attribute|
    test "#{attribute} length should be between 5 and 50" do
      assert_invalid_values(attribute, "x" * 4, "x" * 51)
      assert_valid_values(attribute, "x" * 5, "x" * 50)
    end
  end

  [:sender_email, :receiver_email].each do |attribute|
    test "#{attribute} should allow only valid email addresses" do
      assert_invalid_values(attribute, *%w[user user@localhost])
      assert_valid_values(attribute, *%w[user@example.org user@example.co.uk user.name@example.cn])
    end
  end

  test "receiver_gender should only allow valid genders or be empty" do
    assert_valid_values(:receiver_gender, "", "male", "female")
    assert_invalid_values(:receiver_gender, "other")
  end

  def assert_invalid_values(attribute, *values)
    model = CertificateRequest.new
    values.each do |value|
      model.send("#{attribute}=", value)
      model.valid?
      assert !model.errors[attribute].empty?, "#{attribute} should not allow #{value.inspect}"
    end
  end

  def assert_valid_values(attribute, *values)
    model = CertificateRequest.new
    values.each do |value|
      model.send("#{attribute}=", value)
      model.valid?
      assert model.errors[attribute].empty?, "#{attribute} should allow #{value.inspect}"
    end
  end
end
