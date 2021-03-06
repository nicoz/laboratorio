# ClientSideValidations Initializer

#require 'client_side_validations/simple_form' if defined?(::SimpleForm)
#require 'client_side_validations/formtastic'  if defined?(::Formtastic)

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
	unless html_tag =~ /<label/
		%{<div class="field_with_errors">#{html_tag}<label for="#{instance.send(:tag_id)}" style="display:none" class="help-inline error message">#{instance.error_message.first}</label></div>}.html_safe
	else
		%{<div class="field_with_errors">#{html_tag}</div>}.html_safe
	end
end
