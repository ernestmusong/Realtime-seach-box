Rails.application.routes.draw do
  get '/', to: redirect('/index.html')

   
    resources :searches, only: [:index, :create]

end