# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    def show
      require_authentication
      @ransack_query = current_user.bulletins.ransack params[:query]
      @bulletins = @ransack_query.result.order(created_at: :desc).page params[:page]
      @bulletin_state_options = Bulletin.aasm.states.map { |state| [t(state.name), state.name.to_s] }
    end
  end
end
