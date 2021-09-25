Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup',
               confirmation: 'confirmation',
               password: 'password'
             },
             controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations',
                confirmations: 'users/confirmations',
                passwords: 'users/passwords'
             },
             defaults: { format: :json }
end
