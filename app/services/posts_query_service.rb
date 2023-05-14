class PostsQueryService
  attr_reader :query_params

  def initialize(query_params = {})
    @query_params = query_params
  end

  def self.call(query_params = {})
    new(query_params).call
  end

  def call
    posts = Post.order("posts.created_at DESC")
    posts = posts.title_search(query_params[:title]) if query_params[:title].present?
    posts = posts.author_search(query_params[:author_username]) if query_params[:author_username].present?
    posts = posts.tags_search(query_params[:tag_titles]) if query_params[:tag_titles].present?
    posts
  end
end
