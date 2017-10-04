# frozen_string_literal: true

class UserCable < BaseCable
  def list
    users = User.where("id > ?", params[:min_id]).limit(10_000)

    stream partial: "user/list", locals: { users: users }
  end
end
