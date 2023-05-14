Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

  get '/', to: redirect('/posts')

  resources :users, only: [:create]
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  get "/posts", to: "posts#index"
  get "/posts/new", to: "posts#new", as: :new_post_path
  get "/posts/:id/edit", to: "posts#edit", as: :edit_post_path
  patch "/posts/:id/update", to: "posts#update", as: :update_post_path
  delete "/post/:id/delete", to: "posts#delete", as: :delete_post_path
  post "/posts", to: "posts#create"
  get "/post/:id", to: "posts#show", as: :post

  post "/comments", to: "comments#create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
