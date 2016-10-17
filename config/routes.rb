Rails.application.routes.draw do
  root 'projectse#index'

  resources :projects, only: [:index, :create, :update, :destroy] do
    resources :tasks, only: [:create, :update, :destroy]
    put '/tasks/:id/complete/:complete' => 'tasks#complete'
  end
end
