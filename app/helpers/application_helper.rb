# frozen_string_literal: true

module ApplicationHelper
  GRID_LINK_CLASS = 'btn btn-sm btn-outline-dark me-1'

  BUTTON_LINK_CLASS = 'btn btn-outline-dark me-2'

  ACTIONS_ICONS = {
    show: 'fa-solid fa-eye',
    edit: 'fa-solid fa-pen',
    send_for_moderation: 'fa-solid fa-circle-check',
    archive: 'fa-solid fa-box-archive',
    publish: 'fa-solid fa-circle-check',
    reject: 'fa-solid fa-reply',
    destroy: 'fa-solid fa-trash-can'
  }.freeze

  ACTIONS_HTTP_METODS = {
    show: :get,
    edit: :get,
    send_for_moderation: :patch,
    archive: :patch,
    publish: :patch,
    reject: :patch,
    destroy: :delete
  }.freeze

  def menu_item_link(title, path, **options)
    active = 'active' if request.path == path
    options[:class] = [options[:class], active].join(' ') if active
    link_to title, path, **options
  end

  def icon_action_link(action,
                       path,
                       # title: t(action),
                       http_method: ACTIONS_HTTP_METODS[action],
                       link_class: GRID_LINK_CLASS,
                       enabled: true)
    link_class += ' disabled' unless enabled
    content_tag :span, title: title do
      link_to path, class: link_class, 'data-method' => http_method do
        content_tag :i, '', class: ACTIONS_ICONS[action]
      end
    end
  end

  def button_action_link(action,
                         path,
                         # title: t(action),
                         http_method: ACTIONS_HTTP_METODS[action],
                         link_class: BUTTON_LINK_CLASS)
    link_to path, class: link_class, 'data-method' => http_method do
      (content_tag :span, class: 'me-2' do
        content_tag :i, '', class: ACTIONS_ICONS[action]
      end) + title
    end
  end

  def allow?(action, resource)
    policy(resource).public_send("#{action}?") && aasm_allow?(action, resource)
  end

  private

  def aasm_allow?(action, resource)
    return true unless resource.class.include? AASM

    return true unless action.in?(resource.class.aasm.events.map(&:name))

    resource.aasm.may_fire_event? action
  end
end
