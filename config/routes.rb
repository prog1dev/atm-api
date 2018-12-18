Rails.application.routes.draw do
  namespace :api do
    post :money, to: 'money#create'
    patch :money, to: 'money#update'
  end
end
