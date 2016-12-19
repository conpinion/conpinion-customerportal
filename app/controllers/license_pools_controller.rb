class LicensePoolsController < ApplicationController
  load_and_authorize_resource :license_pool
  add_breadcrumb LicensePool.model_name.human(count: 2), :license_pools_path

  def index
    @q = @license_pools.search(params[:q])
    @q.sorts = 'distributor asc' if @q.sorts.empty?
    @license_pools = @q.result.page(params[:page])
  end

  def show
    add_breadcrumb @license_pool.display_name, @license_pool
  end

  def new
    add_breadcrumb I18n.t('titles.new_model', model: LicensePool.model_name.human), new_license_pool_path
  end

  def create
    if @license_pool.save
      redirect_to license_pools_path, notice: t('messages.model_was_successfully_created',
        model: LicensePool.model_name.human)
    else
      add_breadcrumb I18n.t('titles.new_model', model: LicensePool.model_name.human), new_license_pool_path
      render :new
    end
  end

  def edit
    add_breadcrumb @license_pool.display_name, @license_pool
  end

  def update
    if @license_pool.update license_pool_params
      redirect_to license_pools_path, notice: t('messages.model_was_successfully_updated',
        model: LicensePool.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @license_pool.destroy
    redirect_to license_pools_path, notice: t('messages.model_was_successfully_deleted',
      model: LicensePool.model_name.human)
  end

  private
  def license_pool_params
    params.require(:license_pool).permit :distributor_id, :product_id, :feature_name, :feature_stock
  end
end
