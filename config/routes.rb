Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'travel#index'
  get '/search', to: 'travel#search'
  get '/view', to: 'travel#view'
  get '/message', to: 'travel#message'
  get '/match_schedule', to: 'travel#match_schedule'
end
