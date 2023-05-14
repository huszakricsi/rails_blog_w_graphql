class PostsUpdateService
  attr_reader :post_id, :post_params

  def initialize(post_id, post_params)
    @post_params = post_params
    @post_id = post_id
  end

  def self.call(post_id, post_params)
    new(post_id, post_params).call
  end

  def call
    post = Post.find(post_id)
    post.update(post_params)
    post
  end
end
