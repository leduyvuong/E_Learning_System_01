Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    get "/search",            to: "admin#search"
    get "/admin",             to: "admin#new"
    get "/ac",                to: "users#activities"
    get "/edit",              to: "users#edit"
    get "/home",              to: "users#show"
    get "/signup",            to: "users#new"
    get "/cate",              to: "categories#cate"
    get "/cate_detail",       to: "categories#cate_detail"
    get "/lesson",            to: "lessons#show"
    get "/test",              to: "lessons#test"
    get "/word_summary",      to: "summaries#word_summary"
    get "/login",             to: "sessions#new"
    post "/login",            to: "sessions#create"
    delete "/logout",         to: "sessions#destroy"
    delete "/delete_summary", to: "summaries#unactive"
    post "/add_summary",      to: "summaries#create"   
    post "/join_class",       to: "wordlists#create"
    post "/send_test",        to: "lessons#result_test"
    get "/send_test",        to: "lessons#result_test"
  end
  resources :summaries
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :wordlists
  resources :lessons
  resources :categories
  resources :relationships, only: [:create, :destroy]
  namespace :admin do
    resources :users
    resources :categories
    resources :questions
    resources :answers
    resources :lessons
  end
end
