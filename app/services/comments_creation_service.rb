class CommentsCreationService
  attr_reader :author, :post_id, :comment

  def initialize(author, post_id, comment)
    @author = author
    @post_id = post_id
    @comment = comment
  end

  def self.call(author, post_id, comment)
    new(author, post_id, comment).call
  end

  def call
    post = Post.find(post_id)
    Comment.create(post: post, author: author, body: comment)
  end
end
