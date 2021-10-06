Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

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
