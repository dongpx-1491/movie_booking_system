# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title = " "
    base_title = t "text.booking_system"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      case type
      when "alert", "danger"
        type_toastr = "error"
      when "notice", "success"
        type_toastr = "success"
      else
        type_toastr = "info"
      end
      text = "<script>toastr.#{type_toastr}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
