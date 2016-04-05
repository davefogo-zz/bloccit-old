module UsersHelper
  def user_has_post_activity?(user)
    unless user.posts.count == 0
      true
    end
  end

  def user_has_comment_activity?(user)
    unless user.comments.count == 0
      true
    end
  end
end
