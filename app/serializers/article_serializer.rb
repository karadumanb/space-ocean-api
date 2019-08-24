class ArticleSerializer < ArticleBasicSerializer
    # cache_options enabled: true, cache_length: 12.hours
    attributes :description
    has_many :comments, if: Proc.new { |_, params| params && params[:comments] == true }
end
