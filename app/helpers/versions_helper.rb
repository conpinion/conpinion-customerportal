require_relative '../../lib/version'

module VersionsHelper

  def paper_trail_version object
    t 'messages.version', current: (object.version.try(:index) || object.versions.length) + 1
  end

  def paper_trail_version_long object
    t 'messages.version_of',
      current: (object.version.try(:index) || object.versions.length),
      all: object.versions.length
  end

  def paper_trail_author object
    if object.paper_trail.originator
      User.find(object.paper_trail.originator).display_name
    else
      t('messages.version_author_unknown')
    end
  end

  def title_with_version object, title_attr
    res = object ? object.attributes[title_attr.to_s] : ''
    if (params[:version])
      res += " (#{t('messages.version', current: paper_trail_version_long(object))})"
    end
    res
  end

  def restore_link_to path
    link_to t('actions.restore'), path, method: :put, class: 'btn btn-warning',
      data: {
        'confirm' => t('messages.confirm_restoration'),
        'confirm-cancel' => t('actions.cancel'),
        'confirm-proceed' => t('actions.restore') }
  end
end
