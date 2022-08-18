# frozen_string_literal: true

module Web::Admin
  class BulletinsController < ApplicationController
    def index
      @ransack_query = Bulletin.ransack params[:query]
      @bulletins = @ransack_query.result.order(created_at: :desc).page(params[:page])
      @bulletin_state_options = Bulletin.aasm.states.map { |state| [t(state.name), state.name.to_s] }
    end

    def moderate
      @bulletins = Bulletin.under_moderation.order(created_at: :desc).page(params[:page])
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
