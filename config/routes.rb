News::Application.routes.draw do

  # get "article/index"
root 'stories#latest'

get 'mailer(/:action(/:id(.:format)))' => 'mailer#:action'
get '/music' => 'stories#music'
get '/latest' => 'stories#latest'


resources :users
resources :startups
end
