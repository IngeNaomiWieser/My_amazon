Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index', as: 'home'      # verwijst naar de welcomeController met de action 'index'
  get '/about', to: 'welcome#about'
  get '/contact', to: 'welcome#contact'
  post '/contact', to: 'welcome#submit'

  resources :products        # of je kunt ook dat hieronder doen. Dat zijn de 7 default paths.
  # get '/products', to: 'products#index'
  # get '/products/new', to: 'products#new'
  # post '/products', to: 'products#create'
  # get '/products/:id', to: 'products#show'
  # get '/products/:id/edit', to: 'products#edit'
  # patch('/products/:id', { to: 'products#update' })
  # delete '/products/:id', to: 'products#destroy'

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do         # Doe dit zo, anders wordt de default path iets met de :id, en dat wil je niet want het is een sessie en dat heeft niets met een id te maken. Dus als je met session werkt is het waarschijnlijk slim om het zo te doen.
    delete :destroy, on: :collection        #delete path is now a part of the session collection of paths
  end

  resources :product do
    resources :reviews, only: [:create, :destroy]        # you're nesting the reviews on the product
  end

end
