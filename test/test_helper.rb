ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

Dir[Rails.root.join("test/support/**/*.rb")].each {|f| require f}

class ActiveSupport::TestCase
  self.use_transactional_fixtures = false
  self.use_instantiated_fixtures = false
end

class ActionDispatch::IntegrationTest
  include Capybara
  self.use_transactional_fixtures = false
  self.use_instantiated_fixtures = false
end

class ActionMailer::TestCase
  self.use_transactional_fixtures = false
  self.use_instantiated_fixtures = false
end
