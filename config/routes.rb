Rails.application.routes.draw do
  resources :cities

  get 'reports/bar_chart' => 'reports#bar_chart'
  get 'reports/line_chart' => 'reports#line_chart'
  get 'reports/total' => 'reports#total'
  get 'reports/year' => 'reports#year'
  get 'reports/month' => 'reports#month'

  get 'jobs' => 'jobs#index'
  get 'jobs/:id' => 'jobs#show'
  get 'jobs/cities' => 'jobs#cities'

  root 'jobs#index'
end
