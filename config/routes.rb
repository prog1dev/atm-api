Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :money do
        post  :refill,   to: 'refills#create'
        patch :withdraw, to: 'withdraws#update', as: :withdraw
      end
    end
  end
end
