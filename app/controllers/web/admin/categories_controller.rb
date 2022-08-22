# frozen_string_literal: true

module Web::Admin
  class CategoriesController < ApplicationController
    def index
      @categories = Category.all.order(:name).page(params[:page])
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
      authorize @category
    end

    def update
      @category = Category.find params[:id]
      authorize @category
      if @category.update category_params
        redirect_to admin_categories_path, success: t('.success')
      else
        flash[:warning] = t('.fail')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @category = Category.find params[:id]
      authorize @category
      if @category.destroy
        flash[:success] = t('.success')
      else
        flash[:warning] = t('.fail')
      end
      redirect_to admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
