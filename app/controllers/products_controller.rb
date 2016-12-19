class ProductsController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb Product.model_name.human(count: 2), :products_path

  def index
    if current_user.has_role? :distributor
      @products = Distributor.find_by(responsible: current_user).products
    end
    @q = @products.search(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @products = @q.result.page(params[:page])
  end

  def show
    add_breadcrumb @product.name, @product
  end

  def new
    add_breadcrumb I18n.t('titles.new_model', model: Product.model_name.human), new_product_path
  end

  def create
    if @product.save
      redirect_to products_path, notice: t('messages.model_was_successfully_created',
        model: Product.model_name.human)
    else
      add_breadcrumb I18n.t('titles.new_model', model: Product.model_name.human), new_product_path
      render :new
    end
  end

  def edit
    add_breadcrumb @product.name, @product
  end

  def update
    if @product.update product_params
      redirect_to products_path, notice: t('messages.model_was_successfully_updated',
        model: Product.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: t('messages.model_was_successfully_deleted',
      model: Product.model_name.human)
  end

  private
  def product_params
    params.require(:product).permit :name, :version, :features_json
  end
end
