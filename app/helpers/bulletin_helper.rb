# frozen_string_literal: true

module BulletinHelper
  BULLETIN_STATE_ICONS = {
    draft: 'fa-solid fa-asterisk',
    under_moderation: 'fa-solid fa-magnifying-glass',
    published: 'fa-solid fa-check',
    rejected: 'fa-solid fa-rotate-left',
    archived: 'fa-solid fa-file-zipper'
  }.freeze

  BULLETIN_AUTHOR_ACTIONS = %i[show edit send_for_moderation archive].freeze
  BULLETIN_ADMIN_ACTIONS = %i[show publish reject archive].freeze

  BULLETIN_ACTIONS_DATA = {
    show: {
      path: :bulletin_path,
      icon: 'fa-solid fa-eye'
    },
    edit: {
      path: :edit_bulletin_path,
      icon: 'fa-solid fa-pen'
    },
    send_for_moderation: {
      path: :send_for_moderation_bulletin_path,
      method: :patch,
      icon: 'fa-solid fa-circle-check'
    },
    archive: {
      path: :archive_bulletin_path,
      method: :patch,
      icon: 'fa-solid fa-box-archive'
    },
    admin_show: {
      path: :admin_bulletin_path,
      icon: 'fa-solid fa-eye'
    },
    admin_publish: {
      path: :publish_admin_bulletin_path,
      method: :patch,
      icon: 'fa-solid fa-circle-check'
    },
    admin_reject: {
      path: :reject_admin_bulletin_path,
      method: :patch,
      icon: 'fa-solid fa-reply'
    },
    admin_archive: {
      path: :archive_admin_bulletin_path,
      method: :patch,
      icon: 'fa-solid fa-box-archive'
    }
  }.freeze

  def draw_bulletin_grid_state(bulletin)
    content_tag :span do
      state = bulletin.aasm.current_state
      content_tag :i, '', class: "#{BULLETIN_STATE_ICONS[state]} fa-xl", title: t(state)
    end
  end

  def bulletin_grid_action_links(bulletin, *actions)
    actions = actions.index_with { |action| allow?(delete_ns_prefix(action), bulletin) }

    actions.map do |action, enabled|
      action_data = BULLETIN_ACTIONS_DATA[action]
      path = public_send(action_data[:path], bulletin)
      http_method = action_data[:method] || :get
      icon_class = action_data[:icon]
      title = t(delete_ns_prefix(action))
      icon_action_link enabled, path, http_method, title, icon_class
    end
  end

  def bulletin_form_action_links(bulletin, *actions)
    actions = actions.select do |action|
      allow?(delete_ns_prefix(action), bulletin)
    end

    actions.map do |action|
      action_data = BULLETIN_ACTIONS_DATA[action]
      path = public_send(action_data[:path], bulletin)
      http_method = action_data[:method] || :get
      icon_class = action_data[:icon]

      button_action_link path, http_method, t(delete_ns_prefix(action)), icon_class
    end
  end

  def bulletin_admin_actions
    wrap_actions(*BULLETIN_ADMIN_ACTIONS)
  end

  def bulletin_author_actions
    wrap_actions(*BULLETIN_AUTHOR_ACTIONS)
  end
end
