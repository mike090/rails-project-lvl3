# frozen_string_literal: true

module Web::Admin
  class BulletinsController < ApplicationController
    def index
      @ransack_query = Bulletin.ransack params[:query]
      @bulletins = @ransack_query.result.order(created_at: :desc).page(params[:page])
      @bulletin_state_options = Bulletin.aasm.states.map { |state| [t(state.name), state.name.to_s] }
    end

    def show
      @bulletin = Bulletin.find params[:id]
      @requested_actions = %i[publish reject archive]
    end

    def moderate
      @bulletins = Bulletin.under_moderation.order(created_at: :desc).page(params[:page])
    end

    def publish
      @bulletin = Bulletin.find params[:id]
      if @bulletin.may_publish?
        @bulletin.publish!
        redirect_back fallback_location: admin_root_path, success: t('.success')
      else
        redirect_back fallback_location: admin_root_path, warning: t('.fail', state: t(@bulletin.state))
      end
    end

    def reject
      @bulletin = Bulletin.find params[:id]
      if @bulletin.may_reject?
        @bulletin.reject!
        redirect_back fallback_location: admin_root_path, success: t('.success')
      else
        redirect_back fallback_location: admin_root_path, warning: t('.fail', state: t(@bulletin.state))
      end
    end

    def archive
      @bulletin = Bulletin.find params[:id]
      if @bulletin.may_archive?
        @bulletin.archive!
        redirect_back fallback_location: admin_root_path, success: t('.success')
      else
        redirect_back fallback_location: admin_root_path, warning: t('.fail', state: t(@bulletin.state))
      end
    end
  end
end
