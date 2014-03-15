module ApplicationHelper
  # Returns true or false based on the provided path and condition
  # Possible condition values are:
  #                  Boolean -> true | false
  #                   Symbol -> :exclusive | :inclusive
  #                    Regex -> /regex/
  #   Controller/Action Pair -> [[:controller], [:action_a, :action_b]]
  # Example usage:
  #   is_active_link?('/root', true)
  #   is_active_link?('/root', :exclusive)
  #   is_active_link?('/root', /^\/root/)
  #   is_active_link?('/root', ['users', ['show', 'edit']])
  #
  def is_active_link?(url, condition = nil)
    url = url_for(url).sub(/\?.*/, '') # ignore GET params
    case condition
    when :inclusive, nil
      !request.fullpath.match(/^#{Regexp.escape(url).chomp('/')}(\/.*|\?.*)?$/).blank?
    when :exclusive
      !request.fullpath.match(/^#{Regexp.escape(url)}\/?(\?.*)?$/).blank?
    when Regexp
      !request.fullpath.match(condition).blank?
    when Array
      controllers = [*condition[0]]
      actions     = [*condition[1]]
      (controllers.blank? || controllers.member?(params[:controller])) &&
      (actions.blank? || actions.member?(params[:action]))
    when TrueClass
      true
    when FalseClass
      false
    end
  end

  # Returns css class name. Takes the link's URL and its params
  # Example usage:
  #   active_link_to_class('/root', :class_active => 'on', :class_inactive => 'off')
  #
  def active_link_to_class(url, options = {})
    if is_active_link?(url, options[:active])
      options[:class_active] || 'active'
    else
      options[:class_inactive] || ''
    end
  end
end
