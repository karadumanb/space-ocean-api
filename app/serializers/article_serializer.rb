class ArticleSerializer < BaseSerializer
    # cache_options enabled: true, cache_length: 12.hours
    attributes :id, :description, :title, :user_id

    attribute :user_name do |article|
        article.user.username
    end
end
