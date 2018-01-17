module CommentsHelper
    def authorised_user_to_delete_comment?(comment)
        current_user && (current_user.admin? || current_user == comment.user)
    end
end
