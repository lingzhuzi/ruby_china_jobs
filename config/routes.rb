Rails.application.routes.draw do
  get 'jobs' => 'jobs#index'

  root 'jobs#index'
end
