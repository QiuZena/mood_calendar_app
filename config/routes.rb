# Rails.application.routes.draw do
  # get 'comments/create'
  # get 'comments/destroy'
  # get 'likes/create'
  # get 'likes/destroy'
  
#   get 'users/index'
#   get 'users/new'
#   get 'users/create'
#   get 'users/show'
#   get 'users/edit'
#   get 'users/update'
#   get 'users/destroy'
#   get 'diary_entries/index'
#   get 'diary_entries/new'
#   get 'diary_entries/create'
#   get 'diary_entries/show'
#   get 'diary_entries/edit'
#   get 'diary_entries/update'
#   get 'diary_entries/destroy'


#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
#   # Can be used by load balancers and uptime monitors to verify that the app is live.
#   get "up" => "rails/health#show", as: :rails_health_check

#   # Defines the root path route ("/")
#   # root "posts#index"
# end

Rails.application.routes.draw do
  devise_for :users
  get 'profile', to: 'users#profile', as: 'user_profile'
  root "diary_entries#index"  # 设置首页



  resources :diary_entries do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    member do
      delete :remove_image
    end
  end

  # Rails 的 health check 不用动
  get "up" => "rails/health#show", as: :rails_health_check
end

