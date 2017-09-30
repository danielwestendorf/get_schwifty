# Used for rendering partials in schwifty background jobs
class GetSchwiftyController < ApplicationController
  prepend_view_path Rails.root.join(*%w(app views cables)).to_s
end
