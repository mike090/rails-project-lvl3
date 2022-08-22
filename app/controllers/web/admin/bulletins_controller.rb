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
      @required_actions = %i[publish reject archive]
    end

    def moderate
      @bulletins = Bulletin.under_moderation.order(created_at: :desc).page(params[:page])
    end

    def publish
      @bulletin = Bulletin.find params[:id]
      authorize @bulletin
      complete_action @bulletin.publish!
    end

    def reject
      @bulletin = Bulletin.find params[:id]
      authorize @bulletin
      complete_action @bulletin.reject!
    end

    def archive
      @bulletin = Bulletin.find params[:id]
      authorize @bulletin
      complete_action @bulletin.archive!
    end

    private

    def complete_action(success)
      if success
        flash[:success] = t('.success')
      else
        flash[:danger] = t('.fail')
      end
      redirect_back fallback_location: root_path
    end
  end
end
