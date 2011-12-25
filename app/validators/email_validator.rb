# taken from: http://my.rails-royce.org/2010/07/21/email-validation-in-ruby-on-rails-without-regexp/
require 'mail'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      m = Mail::Address.new(value)
      r = m.domain && m.address == value
      r &&= (m.__send__(:tree).domain.dot_atom_text.elements.size > 1)
    rescue Exception => e
      r = false
    end
    record.errors[attribute] << (options[:message] || "is not a valid email address") unless r
  end
end
