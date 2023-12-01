Rails.application.routes.draw do
  get 'messages/create'
  # Другие маршруты
  get "/about", to: "pages#about", as: :about
  get "/contact", to: "pages#contact", as: :contact

  # Главная страница
  root to: "home#index"

  # Devise маршруты
  devise_for :users, controllers: { registrations: 'registrations' }

  # Перенаправление залогиненных пользователей на страницу редактирования аккаунта
  authenticated :user do
    get '/users/shares', to: 'shares#index', as: :authenticated_shares
    resources :messages, only: [:create] # Маршрут для контроллера сообщений
  end

  # Перенаправление незалогиненных пользователей на страницу входа
  unauthenticated :user do
    root 'devise/sessions#new', as: :unauthenticated_root
  end

  # Маршруты для других ресурсов
  resources :articles
  resources :products

  # Маршруты для акций
  resources :shares, only: [:index, :new, :create]
end