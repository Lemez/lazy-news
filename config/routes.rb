News::Application.routes.draw do

  # get "article/index"
root 'stories#index'

get 'mailer(/:action(/:id(.:format)))' => 'mailer#:action'


end
