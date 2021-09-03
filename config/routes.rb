Rails.application.routes.draw do
  require "sidekiq/web"
  require "sidekiq/cron/web"

  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    get "/user_lesson",   to: "categories#user_lesson"
    get "/admin",         to: "admin#index"
    get "/down_lesson",   to: "lessons#down_lesson"
    get "/home",          to: "users#show"
    get "/signup",        to: "users#new"
    get "/cate",          to: "static_pages#categories"
    get "/login",         to: "sessions#new"
    post "/login",        to: "sessions#create"
    delete "/logout",     to: "sessions#destroy"
    get "/train",         to: "lessons#train"
    get "/signup",        to: "users#new"
    get "/word_summary",  to: "summaries#word_summary"
    get "result_test",    to: "tests#result_test"
    post "result_test",     to: "tests#result_test"
    
    Rails.application.routes.draw do
      mount Sidekiq::Web => "/sidekiq"
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
    resources :tests
    resources :relationships, only: [:create, :destroy]
    namespace :admin do
      post "import", to: "content_lessons#import"
      get "filter", to: "statistics#filter_statistic"
      get "category_statistic", to: "statistics#category_statistic"
      get "export_excel", to: "statistics#export_excel"
      get "pending_category", to: "categories#pending_category"
      post "accept_pending", to: "categories#accept_pending"
      resources :users 
      resources :categories
      resources :questions
      resources :answers
      resources :lessons
      resources :content_lessons
      resources :statistics
    end
  end
end