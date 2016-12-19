Formtastic::Helpers::FormHelper.builder = FormtasticBootstrap::FormBuilder

module FormtasticBootstrap::Helpers::ErrorsHelper
  def semantic_errors(*args)
    html_options = args.extract_options!
    args = args - [:base]
    full_errors = args.inject([]) do |array, method|
      attribute = localized_string(method, method.to_sym, :label) || humanized_attribute_name(method)
      errors = Array(@object.errors[method.to_sym]).to_sentence
      errors.present? ? array << [attribute, errors].join(" ") : array ||= []
    end
    full_errors << @object.errors[:base]
    full_errors.flatten!
    full_errors.compact!
    return nil if full_errors.blank?

    if html_options[:class].blank?
      html_options[:class] = "alert alert-danger"
    else
      html_options[:class] = "alert alert-danger " + html_options[:class]
    end

    Formtastic::Util.html_safe <<-EOS
      <script type="text/javascript">
        $(function(){
          toastr.error("<ul>#{Formtastic::Util.html_safe(full_errors.map { |error| template.content_tag(:li, Formtastic::Util.html_safe(error)) }.join)}</ul>");
        });
      </script>
    EOS
  end
end
