Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'erste-schrittes' => 'tour#willkommen_organizator', as: :willkommen_organizator
  
  post 'testdaten' => 'tour#testdaten', as: :testdaten
  
  root :to => 'welcome#index'
  
  get 'question/:id' => 'question#show'
  
  get 'update' => 'tour#update'
  
  get 'search' => 'welcome#search'

  get 'fehlerbehebung' => 'tour#fehlerbehebung'
  
  get 'fehlerbehebung/formular' => 'tour#fehlerbehebung_form'
  
  get 'ajax/search' => 'tour#searchajax'
  
  get 'quicksearch' => 'welcome#quicksearch'
  
  get 'tour/:path' => 'tour#start_tour'
  
  get 'tour/:path/:step' => 'tour#step'
  
end
