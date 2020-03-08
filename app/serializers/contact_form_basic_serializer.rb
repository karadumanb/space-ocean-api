class ContactFormBasicSerializer < BaseSerializer
  # cache_options enabled: true, cache_length: 12.hours
  attributes :id, :name, :email, :title

  attribute :created_at do |contact_form|
    contact_form.created_at.strftime('%d.%m.%Y')
  end
end
