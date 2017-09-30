require "test_helper"

require "action_dispatch/system_testing/server"
class ActionDispatch::SystemTesting::Server
  def register
    Capybara.register_server :rails_puma do |app, port, host|
      Rack::Handler::Puma.run(app, Port: port, Threads: "5:5")
    end
  end
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
