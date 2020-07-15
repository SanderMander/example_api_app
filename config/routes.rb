Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        member do
          get :movies, to: 'library#movies'
          get :seasons, to: 'library#seasons'
          get :remaining, to: 'library#remaining'
        end
      end
    end
  end
end
