# frozen_string_literal: true
Rails.application.routes.draw do
  resources :athletes, except: [:new, :edit]
  resources :workouts, except: [:new, :edit]
  resources :examples, except: [:new, :edit]
  resources :logs, only: [:create, :update, :destroy, :index]
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  resources :users, only: [:index, :show]
end
