# frozen_string_literal: true

module Web::Admin
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.all.order created_at: :desc
    end

    def moderate
      @bulletins = Bulletin.pending_moderation
    end

    def publish; end

    def reject; end

    def archive; end
  end
end
