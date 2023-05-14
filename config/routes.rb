Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/", to: "pharmacies#index"
  patch "/pharmacies/:id", to: "pharmacies#update"
  get "/pharmacies", to: "pharmacies#index"
  get "/pharmacies/new", to: "pharmacies#new"
  post "/pharmacies", to: "pharmacies#create"
  get "/pharmacies/:id", to: "pharmacies#show"
  get "/pharmacies/:id/edit", to: "pharmacies#edit"
  get "/pharmacies/:pharmacy_id/medications", to: "pharmacy_medications#index"
  get "/medications", to: "medications#index"
  get "/medications/:id", to: "medications#show"
end
