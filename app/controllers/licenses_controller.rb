class LicensesController < ApplicationController
  include VersioningController
  include VersionsHelper
  include StringHelper
  load_and_authorize_resource :customer
  load_and_authorize_resource :license, through: :customer
  add_breadcrumb Customer.model_name.human(count: 2), :customers_path

  def index
    add_breadcrumb @customer.company, @customer
    add_breadcrumb License.model_name.human(count: 2), :customer_licenses_path
    @q = @licenses.search(params[:q])
    @licenses = @q.result.page(params[:page])
  end

  def show
    @license = @license.specific_version params[:version]
    @license_contents = render_to_string '_license_file_contents.txt'
    # TODO: Workaround because render_to_string sets 'Content-Type: text/plain'
    lookup_context.rendered_format = nil
    add_breadcrumb @customer.company, @customer
    add_breadcrumb License.model_name.human(count: 2), :customer_licenses_path
    add_breadcrumb title_with_version(@license, :serial_number), @license
  end

  def download
    respond_to do |format|
      format.text do
        @license_contents = render_to_string '_license_file_contents.txt'
        response.headers['Content-Disposition'] =
          "attachment; filename=\"License-#{sanitize_filename(@license.customer.company)}-#{sanitize_filename(@license.serial_number)}.txt\""
      end
    end
  end

  def new
    add_breadcrumb @customer.company, @customer
    add_breadcrumb License.model_name.human(count: 2), :customer_licenses_path
    add_breadcrumb I18n.t('titles.new_model', model: License.model_name.human),
      new_customer_license_path
  end

  def create
    respond_to do |format|
      format.js do
        @license.init_feature_defaults_from_product
        render :new
      end
      format.html do
        cmd = CreateLicenseCommand.new license: @license
        if cmd.execute
          redirect_to customer_licenses_path(@customer), notice: t('messages.model_was_successfully_created',
            model: License.model_name.human)
        else
          add_breadcrumb @customer.company, @customer
          add_breadcrumb License.model_name.human(count: 2), :customer_licenses_path
          add_breadcrumb I18n.t('titles.new_model', model: License.model_name.human),
            new_customer_license_path
          render :new
        end
      end
    end
  end

  def edit
    add_breadcrumb @customer.company, @customer
    add_breadcrumb License.model_name.human(count: 2), :customer_licenses_path
    add_breadcrumb @license.serial_number, @license
  end

  def update
    cmd = UpdateLicenseCommand.new license: @license, license_attributes: license_params
    if cmd.execute
      redirect_to customer_licenses_path(@customer), notice: t('messages.model_was_successfully_updated',
        model: License.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @license.destroy
    redirect_to customer_licenses_path(@customer), notice: t('messages.model_was_successfully_deleted',
      model: License.model_name.human)
  end

  def license_url license
    customer_license_url license.customer, license
  end

  private
  def license_params
    params.require(:license).permit [:product_id, :machine_code, :valid_until] +
      (@license&.product&.feature_names ||
        Product.find_by(id: params[:license][:product_id])&.feature_names ||
        [])
  end

  def update_restored_object restored_license
    cmd = RestoreLicenseCommand.new current_license: @license, restore_license: restored_license
    cmd.execute
  end
end
