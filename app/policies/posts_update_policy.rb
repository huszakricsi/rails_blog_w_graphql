class PostsUpdatePolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def self.update?(user, post)
    new(user, post).update?
  end

  def update?
    is_allowed?
  end

  private

  def is_allowed?
    is_editor_or_admin? || is_owner_and_writer?
  end

  def is_editor_or_admin?
    [:editor, :admin].include? @user.role.to_sym
  end
  
  def is_owner_and_writer?
    @user.role.to_sym == :writer && @post.author == @user
  end
end
  