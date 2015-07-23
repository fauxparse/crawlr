Rails.application.routes.draw do
  resources :characters do
    post :check, on: :collection
  end

  root to: "characters#index"
end
