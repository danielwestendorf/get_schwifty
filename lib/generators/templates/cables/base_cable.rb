# frozen_string_literal: true

# Base cable class to inherit from when getting schwifty
class BaseCable < GetSchwifty::Cable::Base
  include Rails.application.routes.url_helpers
  # Access to pundit helper methods for authorization
  # include Pundit

  # Utility method shared accross cables for accessing the current user
  # def current_user
  #   identifiers[:user]
  # end
end
