Rails.application.routes.draw do
  devise_for  :users,
              :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    root "devise/sessions#new"
    get "users/auth/trello/callback", :controller => "users/omniauth_callbacks", :action => "trello"
  end

  resources :tasklists
  resources :projects

  post :dashboard, controller: :dashboard, action: :update
  get :dashboard, controller: :dashboard, action: :show
end