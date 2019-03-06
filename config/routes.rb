Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'erste-schritte' => 'tour#willkommen_organizator', as: :willkommen_organizator
  post 'testdaten' => 'tour#testdaten', as: :testdaten
  
  root :to => 'welcome#index'
  
  get 'question/:id' => 'question#show'
  
  get 'update' => 'tour#update'
  
  get 'search' => 'welcome#search'
  
  get 'ajax/search' => 'tour#searchajax'
  
  get 'quicksearch' => 'welcome#quicksearch'
  
  get ':path/:step' => 'tour#step'
  
end
