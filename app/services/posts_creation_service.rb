class PostsCreationService
  attr_reader :author, :post_params

  def initialize(author, post_params)
    @author = author
    @post_params = post_params
  end

  def self.call(author, post_params)
    new(author, post_params).call
  end

  def call
    creation_params = post_params.merge({author: author})
    Post.create(creation_params)
  end
end
