class Article::BaseSerializer < BaseSerializer
  attributes :id, :title, :user_id

  attribute :user_name do |article|
    article.user.username
  end

  attribute :created_at do |article|
    article.created_at.strftime('%d.%m.%Y')
  end
end
