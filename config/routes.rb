Rails.application.routes.draw do
  # get 'books/index'
  root "books#index"
  resources :books do
    resources :comments
  end

  post "/books/:id", to: "borrows#create"
  post "/borrows/:id", to: "borrows#giveback"
  post "/borrows/give/change", to: "borrows#give_credit"
  # resources :borrows
  get "/borrows", to: "borrows#index"
  # devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
