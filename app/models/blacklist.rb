class Blacklist < ActiveRecord::Base
  validates :email, :presence => true, :email => true, :uniqueness => true

  def self.add(email)
    # we ignorer errors here, because the address is already in the database
    Blacklist.create(:email => email)
  end

  def self.blacklisted?(email)
    not Blacklist.find_by_email(email).blank?
  end
end
