Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: 'registrations' }


  devise_scope :user do
	  root 'devise/sessions#new'
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

	get 'home', to: 'static_pages#home'
	get 'testing', to: 'static_pages#testing'
	get 'faq', to: 'static_pages#faq'

  resources :states

  resources :towns do
    collection do
      post :import
    end
  end


end
