# frozen_string_literal: true

module Web::Admin
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.all.order created_at: :desc
    end

    def moderate
      @bulletins = Bulletin.pending_moderation
    end

    def publish
      @bulletin = Bulletin.find params[:id]
      authorize @bulletin
      if @bulletin.publish!
        redirect_to (request.referer || root_path), success: t('.success')
      else
        redirect_to (request.referer || root_path), success: t('.fail')
      end
    end

    def reject
      @bulletin = Bulletin.find params[:id]
      authorize @bulletin
      if @bulletin.reject!
        redirect_to (request.referer || root_path), success: t('.success')
      else
        redirect_to (request.referer || root_path), success: t('.fail')
      end
    end
  end
end
