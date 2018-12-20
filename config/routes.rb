Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :bills, only: [:create] do
        patch :update, to: 'bills#update'
      end
    end
  end
end
