Rails.application.routes.draw do
  resources :characters

  root to: "characters#index"
end
