# frozen_string_literal: true

module BulletinHelper
  BULLETIN_STATE_ICONS = {
    draft: 'fa-solid fa-file-lines',
    under_moderation: 'fa-solid fa-magnifying-glass',
    published: 'fa-solid fa-circle-check',
    rejected: 'fa-solid fa-reply',
    archived: 'fa-solid fa-file-zipper'
  }.freeze

  BULLETIN_ACTIONS_DATA = {
    show: {
      path: :bulletin_path,
      icon: 'fa-solid fa-eye'
    },
    edit: {
      path: :edit_bulletin_path,
      icon: 'fa-solid fa-pen'
    },
    sent_for_moderation: {
      path: :sent_for_moderation_bulletin_path,
      method: :put,
      icon: 'fa-solid fa-circle-check'
    },
    publish: {
      path: :publish_admin_bulletin_path,
      method: :put,
      icon: 'fa-solid fa-circle-check'
    },
    reject: {
      path: :reject_admin_bulletin_path,
      method: :put,
      icon: 'fa-solid fa-reply'
    },
    archive: {
      path: :archive_bulletin_path,
      method: :put,
      icon: 'fa-solid fa-box-archive'
    }
  }.freeze

  def draw_bulletin_state(bulletin)
    content_tag :span do
      state = bulletin.aasm.current_state
      content_tag :i, '', class: BULLETIN_STATE_ICONS[state], title: t(state)
    end
  end

  def bulletin_admin_actions
    %i[show publish reject archive]
  end

  def bulletin_author_actions
    %i[show edit sent_for_moderation archive]
  end

  def bulletin_grid_action_links(bulletin, *actions)
    policy = Pundit.policy(current_user, bulletin)
    actions = actions.index_with { |action| policy.public_send "#{action}?" }

    actions.map do |action, enabled|
      path = public_send(BULLETIN_ACTIONS_DATA[action][:path], bulletin)
      http_method = BULLETIN_ACTIONS_DATA[action][:method] || :get
      icon_class = BULLETIN_ACTIONS_DATA[action][:icon]

      if enabled
        link_to path, class: 'btn btn-sm btn-outline-dark me-1',
                      title: t(action.to_s), 'data-method' => http_method do
          content_tag :span do
            content_tag :i, '', class: icon_class
          end
        end
      else
        content_tag :span, title: t(action.to_s) do
          link_to '#', class: 'btn btn-sm btn-outline-dark me-1 disabled' do
            content_tag :span do
              content_tag :i, '', class: icon_class
            end
          end
        end
      end
    end
  end

  def bulletin_form_action_links(bulletin, *actions)
    policy = Pundit.policy(current_user, bulletin)
    actions = actions.select { |action| policy.public_send "#{action}?" }

    actions.map do |action|
      path = public_send(BULLETIN_ACTIONS_DATA[action][:path], bulletin)
      http_method = BULLETIN_ACTIONS_DATA[action][:method] || :get
      icon_class = BULLETIN_ACTIONS_DATA[action][:icon]

      link_to path, class: 'btn btn-outline-dark me-2', 'data-method' => http_method do
        (content_tag :span, class: 'me-2' do
          content_tag :i, '', class: icon_class
        end) + t(action)
      end
    end
  end
end
