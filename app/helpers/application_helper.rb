# frozen_string_literal: true

module ApplicationHelper
  def menu_item_link(title, path, **options)
    active = 'active' if request.path == path
    options[:class] = [options[:class], active].join(' ') if active
    link_to title, path, **options
  end
end
