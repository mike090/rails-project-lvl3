# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    after_action :set_referer_path, only: %i[edit]

    def index
      @ransack_query = policy_scope(Bulletin).ransack params[:query]
      @bulletins = @ransack_query.result
                                 .includes(image_attachment: :blob)
                                 .order(created_at: :desc)
                                 .page(params[:page]).per(8)
      @category_select_options = Category.all.map { |category| [category.name, category.id] }
    end

    def new
      require_authentication
      authorize Bulletin
      @bulletin = current_user.bulletins.build
    end

    def create
      require_authentication
      authorize Bulletin
      @bulletin = current_user.bulletins.build bulletin_params
      if @bulletin.save
        redirect_to @bulletin, success: t('.success')
      else
        flash[:warning] = t('.fail')
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @bulletin = Bulletin.includes(:user, image_attachment: [:blob]).find(params[:id])
      authorize @bulletin
      @requested_actions = %i[edit send_for_moderation archive] if bulletin_author?
    end

    def edit
      require_authentication
      @bulletin = current_user.bulletins.find params[:id]
      authorize @bulletin
    end

    def update
      require_authentication
      @bulletin = current_user.bulletins.find params[:id]
      authorize @bulletin
      if @bulletin.update bulletin_params
        redirect_to referer_path || profile_path, success: t('.success')
      else
        flash[:warning] = t('.fail')
        render :edit, status: :unprocessable_entity
      end
    end

    def send_for_moderation
      require_authentication
      @bulletin = current_user.bulletins.find params[:id]
      authorize @bulletin
      if @bulletin.may_send_for_moderation?
        @bulletin.send_for_moderation!
        redirect_to (request.referer || profile_path), success: t('.success')
      else
        redirect_to (request.referer || profile_path), warning: t('.fail', state: t(@bulletin.state))
      end
    end

    def archive
      require_authentication
      @bulletin = current_user.bulletins.find params[:id]
      authorize @bulletin
      if @bulletin.may_archive?
        @bulletin.archive!
        redirect_to (request.referer || profile_path), success: t('.success')
      else
        redirect_to (request.referer || profile_path), warning: t('.fail', state: t(@bulletin.state))
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end

    def bulletin_author?
      @bulletin.user_id == current_user.id
    end
  end
end
