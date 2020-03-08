class ContactFormSerializer < ContactFormBasicSerializer
  # cache_options enabled: true, cache_length: 12.hours
  attributes :body

end
