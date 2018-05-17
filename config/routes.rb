Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  root 'static_pages#home'
	get 'testing', to: 'static_pages#testing'
  get 'faq', to: 'static_pages#faq'
	get 'inlocation', to: 'locations#inlocation'

  resources :states

  resources :towns do
    collection do
      post :import
    end
  end

  resources :clinics do
    collection do
      post :import
    end
  end

  resources :locations do
    collection do
      post :import
    end
  end
end
