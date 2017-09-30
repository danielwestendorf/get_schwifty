<% if namespaced? -%>
require_dependency "<%= namespaced_class_path %>/application_cable"
<% end -%>
<% module_namespacing do -%>
class <%= class_name %>Cable < BaseCable
<% actions.each do |action| -%>
  def <%= action %>
    a = 1
    b = 2

    stream partial: "<%= class_name.underscore %>/<%= action %>", locals: { a: a, b: b }
  end
<%= "\n" unless action == actions.last -%>
<% end -%>
end
<% end -%>
