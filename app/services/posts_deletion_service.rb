class PostsDeletionService
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def self.call(post)
    new(post).call
  end

  def call
    post.destroy
  end
end
