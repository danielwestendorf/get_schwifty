# frozen_string_literal: true

require "get_schwifty/helper"
require "get_schwifty/channel"
require "get_schwifty/job"
require "get_schwifty/cable/base"

# :nodoc
module GetSchwifty
  mattr_accessor :allow_rerender
  @@allow_rerender = true

  def self.configure
    yield self
  end

  # :nodoc
  class Engine < ::Rails::Engine
    asset_path = File.expand_path("../../app/assets/javascripts", __FILE__)
    config.assets.paths += [asset_path] if config.respond_to?(:assets)

    initializer :get_schwifty do |_app|
      ActiveSupport.on_load(:action_view) do
        include GetSchwifty::Helper
      end
    end
  end
end
