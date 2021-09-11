Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

  devise_for :users,
             controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations',
                confirmations: 'users/confirmations',
                passwords: 'users/passwords'
             },
             defaults: { format: :json }
end
