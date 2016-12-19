module TableHelper
  def paginated model
    content_tag :div do
      paginate model, theme: 'twitter-bootstrap-3'
    end
  end
end
