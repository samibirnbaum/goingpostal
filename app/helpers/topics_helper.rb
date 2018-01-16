module TopicsHelper
    def admin?
        current_user && current_user.admin? 
    end

    def moderator?
        current_user && current_user.moderator? 
    end
end
