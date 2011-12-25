class GenderValidator < ActiveModel::EachValidator
  GENDERS = %w/male female/.freeze

  def validate_each(record, attribute, value)
    unless GENDERS.include?(value)
      record.errors[attribute] << (options[:message] || "is not a valid gender")
    end
  end
end

