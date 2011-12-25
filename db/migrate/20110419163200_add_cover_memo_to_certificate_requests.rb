class AddCoverMemoToCertificateRequests < ActiveRecord::Migration
  def self.up
    add_column :certificate_requests, :cover_memo, :text
  end

  def self.down
    remove_column :certificate_requests, :cover_memo
  end
end
