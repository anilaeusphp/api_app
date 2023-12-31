module Api
    class CategoriesController < ApplicationController
        before_action :set_category, only: %w[show update destroy]
        #before_action :authenticate_user!

        def index

            @cached_categories = Rails.cache.read("categories")
            unless @cached_categories.blank?
               render json: {data: @cached_categories, message: "Cached categories has been served"}, status: :ok
               return
            end

            @categories = Category.order(created_at: :desc)

            Rails.cache.write("categories",@categories, expire_in: 1.hour)
            unless @categories.blank?
                render json: @categories
            else
                render json: "Henüz bir kategori oluşturulmadı", status: :unprocessable_entity
            end
        end

        def show
            render json: @category
        end

        def create
            @category = Category.new(category_params)
            authorize(@category)
            if @category.save
                render json: @category
            else
                render json: "Kategori oluşturulurken bir hata ile karşılaşıldı", status: :unprocessable_entity
            end
        end

        def update
            authorize(@category)
            if @category.update(category_params)
                render json: @category
            else
                render json: "Kategori güncellenirken bir hata ile karşılaşıldı", status: :unprocessable_entity
            end
        end

        def destroy
            authorize(@category)
            if @category.destroy
                render json: "Kategori başarıyla silindi"
            else
                render json: "Kategori silinirken bir hata ile karşılaşıldı.", status: :unprocessable_entity
            end
        end

        private
        def set_category
            @category = Category.find(params[:id])
        end

        private
        def category_params
            params.require(:category).permit(:name)
        end

    end
end