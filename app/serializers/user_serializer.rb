class UserSerializer < BaseSerializer
  attributes :id, :email, :website_cv, :github, :linked_in, :username

  attribute :name do |user|
    "#{user.first_name || ''} #{user.last_name || ''}".strip
  end
end
