class PostsCreationPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def self.create?(user)
    new(user).create?
  end

  def create?
    is_allowed?
  end

  private

  def is_allowed?
    [:writer, :editor, :admin].include? @user.role.to_sym
  end

end
