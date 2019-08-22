class ArticleSerializer < BaseSerializer
    # cache_options enabled: true, cache_length: 12.hours
    attributes :id, :description, :title, :user_id

    attribute :user_name do |article|
        article.user.username
    end

    attribute :created_at do |article|
        article.created_at.strftime('%d.%m.%Y')
    end

    attribute :image_url, if: Proc.new { |article| article.image_url.attached? } do |article|
        Rails.application.routes.url_helpers.rails_blob_url(article.image_url, only_path: true)
    end
end
