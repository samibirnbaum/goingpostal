class FavoriteMailer < ApplicationMailer
    default from: "samibirnbaum1@gmail.com"

    def new_comment(user, post, comment)

        headers["Message-ID"] = "<comments/#{comment.id}@polar-brushlands-91836.herokuapp.com>"
        headers["In-Reply-To"] = "<post/#{post.id}@polar-brushlands-91836.herokuapp.com>"
        headers["References"] = "<post/#{post.id}@polar-brushlands-91836.herokuapp.com>"
        
        @user = user #storing in IV allows it to be used in view
        @post = post #IV for view
        @comment = comment #IV for view

        mail(to: user.email, subject: "New comment on #{post.title}") #renders the email template with method name new_comment
    end

    def new_post(user, post, topic)

        headers["Message-ID"] = "<post/#{post.id}@polar-brushlands-91836.herokuapp.com>"
        headers["In-Reply-To"] = "<post/#{post.id}@polar-brushlands-91836.herokuapp.com>"
        headers["References"] = "<post/#{post.id}@polar-brushlands-91836.herokuapp.com>"

        @user = user
        @post = post
        @topic = topic

        mail(to: user.email, subject: "New Post #{post.title} for Topic #{@topic.name}")
    end
end
