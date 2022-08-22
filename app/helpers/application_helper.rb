# frozen_string_literal: true

module ApplicationHelper
  GRID_LINK_CLASS = 'btn btn-sm btn-outline-dark me-1'
  BUTTON_LINK_CLASS = 'btn btn-outline-dark me-2'

  def menu_item_link(title, path, **options)
    active = 'active' if request.path == path
    options[:class] = [options[:class], active].join(' ') if active
    link_to title, path, **options
  end

  private

  def add_ns_prefix(action)
    prefix = policy_namespace.nil? ? '' : policy_namespace.name.downcase
    [prefix.split('::'), action].flatten.join('_').to_sym
  end

  def delete_ns_prefix(wrapped_action)
    if policy_namespace.nil?
      wrapped_action
    else
      (wrapped_action.to_s.split('_') - policy_namespace.name.downcase.split('::')).join('_').to_sym
    end
  end

  def wrap_actions(*actions)
    actions.map { |action| add_ns_prefix action }
  end

  def icon_action_link(enabled, path, http_method, title, icon)
    link_class = GRID_LINK_CLASS
    link_class += ' disabled' unless enabled
    content_tag :span, title: title do
      link_to path, class: link_class, 'data-method' => http_method do
        content_tag :i, '', class: icon
      end
    end
  end

  def button_action_link(path, http_method, title, icon)
    link_to path, class: BUTTON_LINK_CLASS, 'data-method' => http_method do
      (content_tag :span, class: 'me-2' do
        content_tag :i, '', class: icon
      end) + title
    end
  end
end
