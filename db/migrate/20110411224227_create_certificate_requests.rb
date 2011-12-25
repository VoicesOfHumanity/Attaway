class CreateCertificateRequests < ActiveRecord::Migration
  def self.up
    create_table :certificate_requests do |t|
      t.string :sender_name
      t.string :sender_email
      t.string :receiver_name
      t.string :receiver_email
      t.string :receiver_gender

      t.timestamps
    end
  end

  def self.down
    drop_table :certificate_requests
  end
end
