class Star < ActiveRecord::Base
validates :recipientName, :senderName, :senderEmail, :presence => true


end
