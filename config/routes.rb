Rails.application.routes.draw do

  namespace :admin do
    resources :pages do
      collection do
        get :create_draft
      end
    end
  end

  match '/static/*path', :to => 'static_content#show', :via => :get, :as => 'static'

end
