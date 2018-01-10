module ApplicationHelper #A module inherited by all classes and therefore its methods are available all over our application

    def form_group_tag(errors, &block) #errors = array - &block = Proc
        css_class = "form-group"
        css_class << " has-error" if errors.any?

        content_tag(:div, capture(&block), class: css_class)
    end


    def avatar_url(user)
        gravatar_id = Digest::MD5::hexdigest(user.email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
    end

end