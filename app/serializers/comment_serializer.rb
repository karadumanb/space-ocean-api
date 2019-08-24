class CommentSerializer < BaseSerializer
    # cache_options enabled: true, cache_length: 12.hours
    attributes :id, :body, :user_name, :article_id
end
