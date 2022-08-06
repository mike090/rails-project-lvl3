module Web
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.all.order :created_at
    end

    def new
      require_authentication
      @bulletin = current_user.bulletins.build
    end

    def create
      @bulletin = current_user.bulletins.build bulletin_params
      if @bulletin.save
        redirect_to bulletins_path, success: t('.success')
      else
        flash[:warning] = t('.fail')
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @bulletin = Bulletin.find params[:id]
    end

    def edit
      @bulletin = Bulletin.find params[:id]
    end

    def update
      @bulletin = Bulletin.find params[:id]
      if @bulletin.update bulletin_params
        
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