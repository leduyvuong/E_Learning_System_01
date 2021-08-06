Rails.application.routes.draw do
  get 'summary/create'
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    get "/edit",              to: "users#edit"
    get "/home",              to: "users#show"
    get "/signup",            to: "users#new"
    get "/cate",              to: "categories#cate"
    get "/cate_detail",       to: "categories#cate_detail"
    get "/login",             to: "sessions#new"
    post "/login",            to: "sessions#create"
    delete "/logout",         to: "sessions#destroy"
    delete "/delete_summary", to: "summaries#unactive"
    post "/add_summary",      to: "summaries#create"   
  end
  resources :summaries
  resources :users
  resources :wordlists
  resources :lessons
  resources :categories
end
