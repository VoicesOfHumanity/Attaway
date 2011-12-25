module SampleData
  AUTOMATIC_CERTIFICATE_REQUEST = {
    "sender_email"    => "sender@example.com",
    "sender_name"     => "sender",
    "receiver_email"  => "receiver@example.com",
    "receiver_name"   => "receiver",
    "receiver_gender" => "male",
    "cover_memo"      => "this should me a custom user message",
  }

  AUTOMATIC_CERTIFICATE_REQUEST_WITH_TIMESTAMPS = AUTOMATIC_CERTIFICATE_REQUEST.merge({
    "created_at" => DateTime.now,
    "updated_at" => DateTime.now,
  })

  MANUAL_CERTIFICATE_REQUEST = {
    "sender_email"    => "sender@example.com",
    "sender_name"     => "sender",
    "receiver_email"  => "",
    "receiver_name"   => "receiver",
    "receiver_gender" => "male",
    "cover_memo"      => "this should me a custom user message",
  }

  MANUAL_CERTIFICATE_REQUEST_WITH_TIMESTAMPS = MANUAL_CERTIFICATE_REQUEST.merge({
    "created_at" => DateTime.now,
    "updated_at" => DateTime.now,
  })
end
