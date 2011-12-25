class CertificateRequest < ActiveRecord::Base
  validates :sender_name, :presence => true, :length => 5..50
  validates :sender_email, :presence => true, :email => true
  validates :receiver_name, :presence => true, :length => 5..50
  validates :receiver_email, :email => {:allow_blank => true}
  validates :receiver_gender, :gender => {:allow_blank => true}

  validate :do_not_allow_duplicated_requests, :on => :create
  attr_protected :confirmation_code
  after_initialize :set_confirmation_code

  def self.confirm?(code)
    return nil if code.blank? or not code.match(/[a-h0-9]{16}/)
    where(:confirmation_code => code).first
  end

  def self.deliver(message_type, certificate_request)
    if not Notifications.respond_to?(message_type)
      raise ArgumentError.new("Unknown message type #{message_type}")
    end
    return if Blacklist.blacklisted?(certificate_request.sender_email)
    return if Blacklist.blacklisted?(certificate_request.receiver_email)
    Notifications.send(message_type, certificate_request).deliver
  end

  def duplicated?(memoize=true)
    if @duplicated.nil? or not memoize
      q = self.class.where("updated_at >= ?", 1.month.ago)
      q = q.where(:sender_email => sender_email)
      q = q.where(:receiver_email => receiver_email)
      q = q.where('id <> ?', request.id) unless new_record?
      @duplicated = (include_receiver? and q.count > 0)
    end
    @duplicated
  end

  def include_receiver?
    receiver_email.present?
  end

private

  def do_not_allow_duplicated_requests
    message = 'Sorry, only one certificate can be sent to the same email address per month.'
    errors.add(:base, message) if duplicated?(false)
  end

  def set_confirmation_code
    self.confirmation_code = ActiveSupport::SecureRandom.hex(8)
  end
end

