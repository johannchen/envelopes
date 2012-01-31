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

  def color_amount(amount)
    amount < 0 ? "red" : "green"
  end

  def beginning_of_this_month
    Date.today.at_beginning_of_month
  end

  def beginning_of_next_month
    Date.today.at_beginning_of_month.next_month
  end

  def start_date
    params[:start_date] ? params[:start_date] : beginning_of_this_month
  end

  def end_date
    params[:end_date] ? params[:end_date] : beginning_of_next_month
  end
end
