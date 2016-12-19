class DownloadsController < ApplicationController
  load_and_authorize_resource :product
  load_and_authorize_resource :download, through: :product
  add_breadcrumb Product.model_name.human(count: 2), :products_path

  def index
    add_breadcrumb @product.display_name, @product
    add_breadcrumb Download.model_name.human(count: 2), :product_downloads_path
    @q = @downloads.search(params[:q])
    @downloads = @q.result.page(params[:page])
  end

  def show
    add_breadcrumb @product.display_name, @product
    add_breadcrumb Download.model_name.human(count: 2), :product_downloads_path
    add_breadcrumb @download.name, @dowload
  end

  def download
    path = @download.file.path(params[:style])
    head(:bad_request) and return unless File.exist?(path)
    @download.update_attribute :download_count, @download.download_count + 1
    send_file path, type: MIME::Types.type_for(path).first.content_type
  end

  def create
    if @download.save
      redirect_to product_downloads_path(@product), notice: t('messages.model_was_successfully_created',
        model: Download.model_name.human)
    else
      add_breadcrumb I18n.t('titles.new_model', model: Download.model_name.human),
        new_product_download_path(@product)
      render :new
    end
  end

  def update
    if @download.update download_params
      redirect_to product_downloads_path(@product),
        notice: t('messages.model_was_successfully_updated', model: Download.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @download.destroy
    redirect_to product_downloads_path(@product), notice: t('messages.model_was_successfully_deleted',
      model: License.model_name.human)
  end

  private
  def download_params
    params.require(:download).permit :name, :description, :file
  end
end
