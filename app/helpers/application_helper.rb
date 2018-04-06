module ApplicationHelper
  def display_voted(content)
    'display: none' unless content.voted? current_user
  end

  def datetime(timestamp)
    timestamp.strftime('%Y %b %d %H:%M:%S')
  end

  def collection_cache_key_for(model)
    klass = model.to_s.capitalize.constantize
    count = klass.count
    max_updated_at = klass.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{model.to_s.pluralize}/collection-#{count}-#{max_updated_at}"
  end

  def collection_relation_cache_key_for(model, resource)
    klass = model.to_s.capitalize.constantize
    max_updated_at = klass.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{model.to_s.pluralize}/#{resource.class}/#{resource.id}/collection-#{max_updated_at}"
  end

  def avatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
