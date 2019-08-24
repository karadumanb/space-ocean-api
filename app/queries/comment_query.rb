class CommentQuery
    include ApplicationHelper

    attr_accessor :comments

    def initialize(comments)
      @comments = comments || Comment.none
    end

    def filter_by(filters)
      filters.each do |filter, values|
        @comments = @comments.where('article_id': values) if filter == 'article_ids'
      end

      @comments
    end
end
