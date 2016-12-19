class DashboardsController < ApplicationController
  using FunctionalRefinements

  def index
    authorize! :read, :dashboard
    if current_user.has_role? :distributor
      distributor = Distributor.find_by(responsible: current_user)
      @graphs = [OpenStruct.new(distributor: distributor)]
    elsif current_user.has_role? :admin
      @graphs = Distributor.all.map do |distributor|
        OpenStruct.new distributor: distributor
      end
    end
  end

  def graph
    authorize! :read, :dashboard
    @distributor = Distributor.find_by id: params[:distributor_id]
    @product = Product.find_by id: params[:product_id]
    authorize! :read, @distributor
    if @product
      authorize! :read, @product
      usages = [
        [
          LicenseUsage.where(distributor: @distributor, product: @product).
            order(:created_at).
            group('strftime("%m/%Y", created_at)').
            maximum(:feature_total),
          @product.display_name
        ]
      ]
    else
      usages = @distributor.products.map { |product|
        [
          LicenseUsage.where(distributor: @distributor, product: product).
            order(:created_at).
            group('strftime("%m/%Y", created_at)').
            maximum(:feature_total),
          product.display_name
        ]
      }.reject { |u| u[0].empty? }
    end
    (time_min, time_max) = usages.
      map { |u| u[0].keys.map{|k| Date.parse k}}.
      map { |u| [u.min, u.max] }.
      transpose.
      as { |u| u.present? ? [u[0].min, u[1].max] : [nil, nil] }
    if time_min && time_max
      @labels = (time_min..time_max).
        map { |d| Date.new d.year, d.month, 1 }.
        uniq.
        map { |d| d.strftime '%m/%Y' }
      @data = @labels.map { |l| usages.map { |u| u[0][l] } }.
        transpose.
        each_with_index.
        map { |d, idx| { name: usages[idx][1], data: d } }
    else
      @labels = []
      @data = usages.map { |u| { name: u[1] } }
    end
  end
end
