module Versionable

  extend ActiveSupport::Concern

  included do
    has_paper_trail
  end

  def specific_version num
    return self unless num
    raise ActiveRecord::RecordNotFound unless num =~ /\d+/
    version_index = num.to_i
    raise ActiveRecord::RecordNotFound unless (version_index >= 0) && (version_index <= versions.length)
    return self if version_index == versions.length
    versions[version_index].reify
  end

  def version_number
    version ? version.index + 1 : versions.length
  end
end
