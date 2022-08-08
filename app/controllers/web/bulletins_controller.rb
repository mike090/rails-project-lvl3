# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.includes(image_attachment: :blob).all.order :created_at
    end

    def new
      require_authentication
      @bulletin = current_user.bulletins.build
    end

    def create
      require_authentication
      @bulletin = current_user.bulletins.build bulletin_params
      if @bulletin.save
        redirect_to root_path, success: t('.success')
      else
        flash[:warning] = t('.fail')
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @bulletin = Bulletin.includes(:user, image_attachment: [:blob]).find(params[:id])
    end

    def edit
      require_authentication
      @bulletin = Bulletin.find params[:id]
      authorize @bulletin
    end

    def update
      require_authentication
      @bulletin = Bulletin.find params[:id]
      authorize @bulletin
      if @bulletin.update bulletin_params
        redirect_to root_path, success: t('.success')
      else
        flash[:warning] = t('.fail')
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
