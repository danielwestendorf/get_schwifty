module GetSchwifty
  module Cable
    class Base
      attr_reader :schwifty_job_id, :identifiers, :params

      def initialize(schwifty_job_id, params, identifiers)
        @schwifty_job_id = schwifty_job_id
        @identifiers = identifiers.symbolize_keys!
        @params = params
      end

      private

      def stream(*args)
        ActionCable.server.broadcast(
          schwifty_job_id,
          GetSchwiftyController.renderer.new.render(*args).squish
        )
      end
    end
  end
end
