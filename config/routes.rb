Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/pharmacies", to: "pharmacies#index"
  get "/pharmacies/:id", to: "pharmacies#show"
end
