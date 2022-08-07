# frozen_string_literal: true

module Web::Admin
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.all.order :created_at
    end

    def moderate
      @bulletins = Bulletin.all.order :created_at
    end

    def publish; end

    def reject; end

    def archive; end
  end
end
