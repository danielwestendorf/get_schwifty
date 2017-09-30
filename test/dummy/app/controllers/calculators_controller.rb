class CalculatorsController < ApplicationController
  def index
    cookies.signed[:user_id] = User.create(fibonacci: SecureRandom.rand(10..35)).id
  end
end
