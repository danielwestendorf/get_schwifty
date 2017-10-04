# frozen_string_literal: true

# Job for running schwifty cables in ActiveJob
class GetSchwiftyRunnerJob < ApplicationJob
  include GetSchwifty::Job
end
