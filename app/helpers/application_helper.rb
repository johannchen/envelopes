module ApplicationHelper
  def flash_messages
    [:info, :success, :warning, :error, :alert, :notice].map do |type|
      if flash[type]
        content_tag(:div, :class => "alert-message #{type}") do
          content_tag(:p, h(flash[type]))
        end
      end
    end.join.html_safe
  end
end
