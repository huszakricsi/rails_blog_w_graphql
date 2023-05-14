class PostsUpdateService
  attr_reader :post, :post_params

  def initialize(post, post_params)
    @post_params = post_params
    @post = post
  end

  def self.call(post, post_params)
    new(post, post_params).call
  end

  def call
    post.update(post_params)
    post
  end
end
