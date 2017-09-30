# Base cable class to inherit from when getting schwifty
class BaseCable < GetSchwifty::Cable::Base
  # Access to pundit helper methods for authorization
  # include Pundit

  # Utility method shared accross cables for accessing the current user
  # def current_user
  #   identifiers[:user]
  # end
end
