class CreateStars < ActiveRecord::Migration
  def self.up
    create_table :stars do |t|
      t.decimal :id
      t.string :recipientName
      t.string :recipientEmail
      t.string :senderName
      t.string :senderEmail
      t.string :certificateDate
      t.date :creationDate

      t.timestamps
    end
  end

  def self.down
    drop_table :stars
  end
end
