# frozen_string_literal: true

module BulletinHelper

  BULLETIN_STATE_ICONS = {
    draft:            'fa-solid fa-file-lines',
    under_moderation: 'fa-solid fa-magnifying-glass',
    published:        'fa-solid fa-circle-check',
    rejected:         'fa-solid fa-reply',
    archived:         'fa-solid fa-file-zipper'
  }

  def draw_bulletin_state(bulletin)
    render 'web/shared/bulletin_state', icon_class: BULLETIN_STATE_ICONS[bulletin.state.to_sym], title: t(bulletin.state)
  end
end
