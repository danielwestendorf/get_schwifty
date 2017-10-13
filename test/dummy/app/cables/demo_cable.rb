# frozen_string_literal: true

class DemoCable < BaseCable
  def build
    sleep 5

    redirect demo_path(id: DateTime.current)
  end
end
