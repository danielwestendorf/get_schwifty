# frozen_string_literal: true

module GetSchwifty
  # :nodoc
  module Job
    def perform(schwifty_job_id, klass_name, method, params, *identifiers)
      klass_name.constantize.new(schwifty_job_id, params, Hash[*identifiers]).send(method)
    end
  end
end
