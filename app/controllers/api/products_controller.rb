module Api
  class ProductsController < ApplicationController
    before_action :set_product, only: %w[show update destroy]
    before_action :authenticate_user!    

    def index
      @products = Product.all
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