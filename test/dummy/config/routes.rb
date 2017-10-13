# frozen_string_literal: true

Rails.application.routes.draw do
  resources :demos, only: %i[index show]

  root "calculators#index"
end
