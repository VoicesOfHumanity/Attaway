Attaway::Application.routes.draw do
  get "success/new"

  resources :certificate_request, :only => [:new, :create]
  resources :certificate_confirmation, :only => [:new, :create]
  resources :block, :only => [:new, :create]
  resources :captcha, :only => [:new]

  get "/success" => "success#new", :as => :success
  get "/confirm" => "certificate_confirmation#new", :as => :confirm
  get "/unsubscribe/kaput" => "unsubscribe#kaput"
  get "/:target/unsubscribe/:code" => "unsubscribe#new", :as => :unsubscribe, :target => /s|r/, :code => /[a-h0-9]{16}/

  root :to => "certificate_request#new"
end
