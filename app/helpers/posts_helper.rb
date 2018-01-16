module PostsHelper
    def users_own?(post)
        current_user && current_user == post.user
    end

    def moderator?
        current_user && current_user.moderator?
    end

    def admin?
        current_user && current_user.admin?
    end
end
