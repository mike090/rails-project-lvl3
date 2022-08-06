module Web::Admin
  class CategoriesController < ApplicationController
    def index
      @categories = Category.all.order(:name)
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new category_params
      if @category.save
        redirect_to admin_categories_path, success: t('.success')
      else
        flash[:warning] = t('.fail')
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @category = Category.find params[:id]
    end

    def update
      @category= Category.find params[:id]
      if @category.update category_params
        redirect_to admin_categories_path, success: t('.success')
      else
        flash[:warning] = t('.fail')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @category = Category.find params[:id]
      begin
        @category.destroy
        flash[:success] = t('.success')
      rescue ActiveRecord::DeleteRestrictionError
        flash[:warning] = t('.fail_has_references')
      rescue StandardError => e
        flash[:warning] = t('.fail')
        # flash[:warning] = e.full_message
      end
      redirect_to admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end