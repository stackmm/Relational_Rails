Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/", to: "pharmacies#index"
  patch "/pharmacies/:id", to: "pharmacies#update"
  get "/pharmacies", to: "pharmacies#index"
  get "/pharmacies/new", to: "pharmacies#new"
  post "/pharmacies", to: "pharmacies#create"
  get "/pharmacies/:id", to: "pharmacies#show"
  get "/pharmacies/:id/edit", to: "pharmacies#edit"

  get "/pharmacies/:id/medications", to: "pharmacies/medications#index"
  get "/pharmacies/:id/medications/new", to: "pharmacies/medications#new"
  post "/pharmacies/:id/medications", to: "pharmacies/medications#create"

  get "/medications", to: "medications#index"
  get "/medications/:id", to: "medications#show"
  get "/medications/:id/edit", to: "medications#edit"
  patch "/medications/:id", to: "medications#update"
end
