class DistributorsController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb Distributor.model_name.human(count: 2), :distributors_path

  def index
    @q = @distributors.search(params[:q])
    @q.sorts = 'company asc' if @q.sorts.empty?
    @distributors = @q.result.page(params[:page])
  end

  def show
    add_breadcrumb @distributor.company, @distributor
  end

  def new
    add_breadcrumb I18n.t('titles.new_model', model: Distributor.model_name.human), new_distributor_path
  end

  def create
    if @distributor.save
      redirect_to distributors_path, notice: t('messages.model_was_successfully_created',
        model: Distributor.model_name.human)
    else
      add_breadcrumb I18n.t('titles.new_model', model: Distributor.model_name.human), new_distributor_path
      render :new
    end
  end

  def edit
    add_breadcrumb @distributor.company, @distributor
  end

  def update
    if @distributor.update distributor_params
      redirect_to distributors_path, notice: t('messages.model_was_successfully_updated',
        model: Distributor.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @distributor.destroy
    redirect_to distributors_path, notice: t('messages.model_was_successfully_deleted',
      model: Distributor.model_name.human)
  end

  private
  def distributor_params
    params.require(:distributor).permit :company, :address_street, :address_zip_code,
      :address_city, :address_country, :responsible_id, product_ids: []
  end
end
