class PostsDeletionPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def self.delete?(user, post)
    new(user, post).delete?
  end

  def delete?
    is_allowed?
  end

  private

  def is_allowed?
    is_admin? || is_owner_and_editor?
  end

  def is_admin?
    @user.role.to_sym == :admin
  end
  
  def is_owner_and_editor?
    @user.role.to_sym == :editor && @post.author == @user
  end
end
  