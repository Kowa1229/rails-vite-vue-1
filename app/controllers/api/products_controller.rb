class Api::ProductsController < Api::ApiController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @q = Product.ransack({name_i_cont: params[:q]})
    @pagy, @products = pagy(@q.result(distinct: true), items: 10)

    # https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/howto/add_pagination_links.md
    render json: @products.order(id: :desc), meta: meta_attributes(@pagy)
  end

  def show
    render json: @product
  end

  def new
    @product = Product.new
    render json: @product
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :ok
    else
      render json: @product, status: :unprocessable_entity
    end
  end

  def edit
    render json: @product
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      render json: @product, status: :ok
    else
      render json: @product, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:id, :name, :price, :description)
  end
end
