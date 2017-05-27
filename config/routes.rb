Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index', as: 'home'      # verwijst naar de welcomeController met de action 'index'

  get '/contact', to: 'welcome#contact'
  post '/contact', to: 'welcome#submit'

  get '/about', to: 'welcome#about'

  get '/questions', to: 'questions#index'
  # namespace :admin do
  #   resources :questions
  # end
  #
  get '/products', to: 'product#index'
  get '/products/new', to: 'product#new', as: :new_product
  post '/products', to: 'product#create'
  get '/products/:id', to: 'product#show', as: :product
  get '/products/:id/edit', to: 'product#edit', as: :edit_product
  patch('/products/:id', { to: 'product#update' })
  delete '/products/:id', to: 'product#destroy'

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :product do
  resources :reviews, only: [:create, :destroy]
  end

end
