class CustomersController < ApplicationController
  include VersioningController
  include VersionsHelper
  load_and_authorize_resource
  add_breadcrumb Customer.model_name.human(count: 2), :customers_path

  def index
    @q = @customers.search(params[:q])
    @q.sorts = 'company asc' if @q.sorts.empty?
    @customers = @q.result.page(params[:page])
  end

  def show
    @customer = @customer.specific_version params[:version]
    add_breadcrumb title_with_version(@customer, :company), @customer
  end

  def new
    add_breadcrumb I18n.t('titles.new_model', model: Customer.model_name.human), new_customer_path
  end

  def create
    unless current_user.has_role? :admin
      @customer.distributor = Distributor.find_by responsible: current_user
    end
    if @customer.save
      redirect_to customers_path, notice: t('messages.model_was_successfully_created',
        model: Customer.model_name.human)
    else
      add_breadcrumb I18n.t('titles.new_model', model: Customer.model_name.human), new_customer_path
      render :new
    end
  end

  def edit
    add_breadcrumb @customer.company, @customer
  end

  def update
    if @customer.update customer_params
      redirect_to customers_path, notice: t('messages.model_was_successfully_updated',
        model: Customer.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: t('messages.model_was_successfully_deleted',
      model: Customer.model_name.human)
  end

  private
  def customer_params
    params.require(:customer).permit :name, :company, :address_street,
      :address_zip_code, :address_city, :address_country, :distributor_id,
      :responsible_id
  end
end
