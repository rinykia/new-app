Rails.application.routes.draw do
 
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :administrators
  get 'administrators/dasboard', as: 'administrator_root'

  root 'site/static#home'

  scope module: 'site' do
    resources :comments, only: [:create, :index]
    resources :messages
    resources :menus do
      resources :menu_items
    end 
    resources :albums  
    resources :photos
    
    resources :reviews, only: [:create, :index]
  end

  namespace :administrators do
    resources :comments
    resources :reviews
    resources :messages
    resources :albums 
    resources :photos
    resources :menu_items
    resources :menus   
  end  
  
end
