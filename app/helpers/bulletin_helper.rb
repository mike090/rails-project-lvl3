# frozen_string_literal: true

module BulletinHelper
  BULLETIN_STATE_ICONS = {
    draft: 'fa-solid fa-asterisk',
    under_moderation: 'fa-solid fa-magnifying-glass',
    published: 'fa-solid fa-check',
    rejected: 'fa-solid fa-rotate-left',
    archived: 'fa-solid fa-file-zipper'
  }.freeze

  def draw_bulletin_grid_state(bulletin)
    content_tag :span do
      content_tag :i, '', class: "#{BULLETIN_STATE_ICONS[bulletin.aasm.current_state]} fa-xl", title: t(bulletin.state)
    end
  end
end
