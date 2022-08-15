# frozen_string_literal: true

module BulletinRules
  extend Referee

  define_checker(:author) { |user, bulletin| bulletin.user_id == user.id }
  define_checker(:admin) { |user| user.admin == true }
  define_checker(:published_bulletin) { |_user, bulletin| bulletin.state == 'published' }
  define_checker(:invalid_aasm_transition) do |_user, bulletin, event|
    if subject.is_a?(Bulletin)
      event.in?(Bulletin.aasm.events.map(&:name)) &&
        !event.in?(bulletin.aasm.events.map(&:name))
    else
      false
    end
  end

  forbid_if_not_allowed
  allow User, :create, Bulletin
  allow :author, :edit, Bulletin
  allow :all, :read, :published_bulletin
  allow %i[author admin], :read, Bulletin
  allow %i[author admin], :archive, Bulletin
  allow :author, :sent_for_moderation, Bulletin
  allow :admin, :publish, Bulletin
  allow :admin, :reject, Bulletin
  deny :all, :edit, :published_bulletin
  deny :all, :all, :invalid_aasm_transition

  def self.allow?(user, scope, bulletin)
    all_allow? user, scope, bulletin
  end
end
