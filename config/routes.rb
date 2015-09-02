Pong::Application.routes.draw do
  resources :matches, except: [:destroy] do
    collection do
      get 'rankings'
      get 'players'
    end
  end
  resources :players
  root to: 'matches#rankings'
end
