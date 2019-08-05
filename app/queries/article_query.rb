class ArticleQuery
    include ApplicationHelper

    attr_accessor :articles

    def initialize(articles)
      @articles = articles || Article.none
    end

    def filter_by(filters)
      filters.each do |filter, values|
        @articles = @articles.where('user_id': values) if filter == 'user_ids'
      end

      @articles
    end
end
