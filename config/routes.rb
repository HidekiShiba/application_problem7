Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }
  resources :users, only: [:show, :index, :edit, :update] do
    member do
      get :following, :followers
    end
  end

  get 'search' => "searches#search"
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

end