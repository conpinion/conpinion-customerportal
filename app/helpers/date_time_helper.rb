module DateTimeHelper
  def format_validity_date date
    date ? l(date) : t('time.unlimited')
  end
end
