class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    if params[:search].present? 
      @products =  Product.where('name LIKE ?', "%#{params[:search]}")
      render json: @products.map { |product| product.as_json.merge({ image: url_for(product.image) }) }
    else 
      @products =  Product.paginate(page: params[:page])
      render json: { products:  @products.map { |product| product.as_json.merge({ image: url_for(product.image) }) }, page: @products.current_page, pages: @products.total_pages}
    end 
  end

  def new
  end 

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

 

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :quantity, :image)
    end
end
