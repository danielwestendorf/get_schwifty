require "get_schwifty/helper"
require "get_schwifty/channel"
require "get_schwifty/job"
require "get_schwifty/cable/base"

module GetSchwifty
  class Engine < ::Rails::Engine
    config.assets.paths += [File.expand_path("../../app/assets/javascripts", __FILE__)] if config.respond_to?(:assets)

    initializer :get_schwifty do |app|
      ActiveSupport.on_load(:action_view) do
        include GetSchwifty::Helper
      end
    end
  end
end
