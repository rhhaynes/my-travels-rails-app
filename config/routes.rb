Rails.application.routes.draw do
  root 'pages#registration'
  get  '/about' => 'pages#about'

  get    '/home'                 => 'sessions#index'
  get    '/login'                => 'sessions#new'
  get    '/auth/github/callback' => 'sessions#create'
  post   '/sessions'             => 'sessions#create'
  delete '/logout'               => 'sessions#destroy'

  get    '/destinations/:slug'   => 'destinations#show', :param => :slug, :as => "destination"

  resources :travels, :except => [:index, :new, :create] do
    resources :logs, :except => [:index]
  end

  get    '/signup'             => 'users#new'
  post   '/users'              => 'users#create'
  get    '/:slug'              => 'users#show',         :param => :slug, :as => "user"
  get    '/:slug/edit'         => 'users#edit',         :param => :slug, :as => "edit_user"
  patch  '/:slug'              => 'users#update',       :param => :slug
  put    '/:slug'              => 'users#update',       :param => :slug
  delete '/:slug'              => 'users#destroy',      :param => :slug

  get    '/:slug/destinations' => 'destinations#index', :param => :slug, :as => "destinations"

  get    '/:slug/travels'      => 'travels#index',      :param => :slug, :as => "travels"
  get    '/:slug/travels/new'  => 'travels#new',        :param => :slug, :as => "new_travel"
  post   '/:slug/travels'      => 'travels#create'
end
