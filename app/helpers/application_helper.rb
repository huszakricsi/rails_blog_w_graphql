module ApplicationHelper
  def usernames_that_have_posts
    Rails.cache.fetch(:usernames_that_have_posts, race_condition_ttl: 5.seconds, expires_in: 30.seconds) do
      User.where(id: Post.all.pluck(:author_id).uniq).pluck(:username)
    end
  end

  def tag_names_that_have_posts
    Rails.cache.fetch(:tags_that_have_posts, race_condition_ttl: 5.seconds, expires_in: 30.seconds) do
      Tag.where(id: Tagging.all.pluck(:tag_id).uniq).pluck(:name)
    end
  end
end
