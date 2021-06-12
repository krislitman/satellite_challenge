Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'stats', to: 'stats#find'
      get 'health', to: 'health#current'
    end
  end
end
