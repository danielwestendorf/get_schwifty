# frozen_string_literal: true

require "test_helper"

module GetSchwifty
  class Test < ActiveSupport::TestCase
    test "mattr configuration" do
      GetSchwifty.allow_rerender = false
      refute GetSchwifty.allow_rerender
    end

    test "configuraiton block" do
      GetSchwifty.configure { |config| config.allow_rerender = false }
      refute GetSchwifty.allow_rerender
    end
  end
end
