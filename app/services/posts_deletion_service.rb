class PostsDeletionService
  attr_reader :post_id

  def initialize(post_id)
    @post_id = post_id
  end

  def self.call(post_id)
    new(post_id).call
  end

  def call
    Post.find(post_id).destroy
  end
end
