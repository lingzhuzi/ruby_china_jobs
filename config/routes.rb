Rails.application.routes.draw do
  get 'jobs' => 'jobs#index'
  get 'jobs/:id' => 'jobs#show'

  root 'jobs#index'
end
