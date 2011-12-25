class AddConfirmationCodeToCertificateRequests < ActiveRecord::Migration
  def self.up
    add_column :certificate_requests, :confirmation_code, :string
  end

  def self.down
    remove_column :certificate_requests, :confirmation_code
  end
end
