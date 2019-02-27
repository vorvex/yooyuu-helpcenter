Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'erste-schritte' => 'tour#willkommen_organizator', as: :willkommen_organizator
  post 'testdaten' => 'tour#testdaten', as: :testdaten
  
  get 'tour/:name/:step' => 'tour#step'
  
  get 'update' => 'tour#update'
  
  get 'ajax/search' => 'tour#searchajax'
  
  get 'question/:id' => 'question#show'
  
end
