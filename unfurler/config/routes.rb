Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'unfurlers#index'
  resource :unfurler, only: %i(index create)
end
