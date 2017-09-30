module GetSchwifty
  module Generators
    class CableGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../../templates", __FILE__)
      argument :actions, type: :array, default: [], banner: "action action"

      def create_cable_files
        template "cables/cable.rb", File.join("app", "cables", class_path, "#{file_name}_cable.rb")

        actions.each do |action|
          template "views/cables/action.html.erb", File.join("app", "views", "cables", class_path, file_name, "_#{action}.html.erb")
        end
      end

      def print_readme
        readme "CABLE"
      end
    end
  end
end
