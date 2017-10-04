# frozen_string_literal: true

module GetSchwifty
  # :nodoc
  module Channel
    def subscribed
      reject if route.blank?

      stream_from channel_name
      GetSchwiftyRunnerJob.perform_later(channel_name, controller, action, params, *identifiers.flatten)
    end

    def rendered
      Rails.cache.write(channel_name, nil) unless GetSchwifty.allow_rerender
    end

    def route
      Rails.cache.read(channel_name)
    end

    def controller
      (route.split("#").first + "_cable").camelize
    end

    def action
      route.split("#").last
    end

    def identifiers
      connection.identifiers.collect do |key|
        [key.to_s, send(key)]
      end
    end

    def schwifty_job_id
      params[:id]
    end

    def channel_name
      "get_schwifty:#{schwifty_job_id}"
    end
  end
end
