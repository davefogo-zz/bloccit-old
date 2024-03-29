class FavoriteMailer < ApplicationMailer
  default from: "davefogo@gmail.com"

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@frozen-savannah-45290.heroku.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@frozen-savannah-45290.heroku.com"
    headers["References"] = "post/#{post.id}@frozen-savannah-45290.heroku.com"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(post)
    headers["Message-ID"] = "<post/#{post.id}@frozen-savannah-45290.heroku.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@frozen-savannah-45290.heroku.com"
    headers["References"] = "post/#{post.id}@frozen-savannah-45290.heroku.com"

    @post = post

    mail(to: post.user.email, subject: "Favorited #{post.title}")
  end
end
