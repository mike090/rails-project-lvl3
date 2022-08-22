# frozen_string_literal: true

module CategoryHelper

  CATEGORY_ACTIONS = %i[edit delete]

  CATEGORY_ACTIONS_DATA = {
    admin_edit: {
      path: :edit_admin_category_path,
      icon: 'fa-solid fa-pen'
    },
    admin_destroy: {
      path: :admin_category_path,
      method: :delete,
      icon: 'fa-solid fa-trash-can'
    }
  }

  def category_grid_action_links(category, *actions)
    policy = policy(category)
    actions = actions.index_with { |action| policy.public_send "#{delete_ns_prefix(action)}?" }
    actions.map do |action, enabled|
      path = public_send(CATEGORY_ACTIONS_DATA[action][:path], category)
      http_method = CATEGORY_ACTIONS_DATA[action][:method] || :get
      icon_class = CATEGORY_ACTIONS_DATA[action][:icon]
      title = t(delete_ns_prefix(action))
      icon_action_link enabled, path, http_method, title, icon_class
    end
  end
end