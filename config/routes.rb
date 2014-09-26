Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :tasklists
  resources :projects

  post :dashboard, controller: :dashboard, action: :update
  get :dashboard, controller: :dashboard, action: :show

  devise_scope :user do
    get "users/auth/trello/callback", :controller => "users/omniauth_callbacks", :action => "trello"
  end
end