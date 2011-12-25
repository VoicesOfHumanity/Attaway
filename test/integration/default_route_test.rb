require 'test_helper'

class DefaultRouteTest < ActionDispatch::IntegrationTest
  test "default route" do
    assert_recognizes(
      {:controller => "certificate_request", :action => "new"},
      {:method => "get", :path => "/"}
    )
  end
end
