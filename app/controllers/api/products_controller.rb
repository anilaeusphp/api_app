module Api
  class ProductsController < ApplicationController
    before_action :set_product, only: %w[show update destroy]
    #before_action :authenticate_user!    

    def index
      @cached_products = Rails.cache.read("products")
      unless @cached_products.blank?
        render json: {data: @cached_products, message: "Cached data has been served."}, status: :ok
        return
      end
      @products = Product.all
      Rails.cache.write("products",@products, expire_in: 1.hour)
      unless(@products.blank?)
        @message = "Products listed."
        render :index, status: :ok
      else
        @message = "Products empty"
        render :error, status: :bad_request
      end
    end

    def show
      @message = "Single Product has been showed"
      render :show, status: :ok
    end

    def create
      @product = Product.new(product_params)
      authorize(@product)
      if @product.valid?
        @product.save
        @message = "Product has been created successfully"
        render :create, status: :created
      else
        @message= @product.errors.full_messages
        render :error , status: :bad_request
      end
    end

    def update
      authorize(@product)
      if @product.update(product_params)
        render json: @product
      end
    end

    def destroy
      authorize(@product)
      if @product.destroy
        @message = "Product has been deleted succesfully"
        render :destroy , status: :ok
      end
    end

    

    private
    def product_params
      params.require(:product).permit(:name, :description, :quantity, :price, :image, :category_id)
    end

    private
    def set_product
        @product = Product.find(params[:id])
    end
  end
end