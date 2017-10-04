module GetSchwifty
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Installs required files for getting schwifty in here"

      def copy_initializer
        template "get_schwifty.rb", "config/initializers/get_schwifty.rb"
      end

      def copy_controller
        template "controllers/get_schwifty_controller.rb", "app/controllers/get_schwifty_controller.rb"
      end

      def copy_channel
        template "channels/get_schwifty_channel.rb", "app/channels/get_schwifty_channel.rb"
      end

      def copy_job
        template "jobs/get_schwifty_runner_job.rb", "app/jobs/get_schwifty_runner_job.rb"
      end

      def create_cables_directories
        empty_directory "app/cables"
        empty_directory "app/views/cables"
      end

      def copy_base_cable
        template "cables/base_cable.rb", "app/cables/base_cable.rb"
      end

      def autoload_cables_path
       application %(config.autoload_paths << config.root.join("app", "cables"))
      end

      def copy_get_schwifty_channel_js
        template "assets/javascripts/get_schwifty_channel.js", "app/assets/javascripts/channels/get_schwifty_channel.js"
      end

      def print_readme
        readme "INSTALL"
      end
    end
  end
end
