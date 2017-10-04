# GetSchwifty configuration initializer
# Use this file to configure GetSchwifty for your needs
GetSchwifty.configure do |config|
  # Configure re-rendering
  #
  # By default, job parameters are stored in the Rails cache and not removed after render
  # If your're not expring keys with a Least Recently Used policy, you cache could fill up
  # with values which will never be accessed again.
  #
  # Allow rerendering
  # This allows caching of `get_schwifty` helper calls in views
  # config.allow_rerender = true # Default

  # Disable rerendering
  # This disables rerendering, and the cachability of `get_schwifty` helper calls. Subscriptions
  # will be rejected after the first render of a cached `get_schwifty` call
  # config.allow_rerender = false
end
