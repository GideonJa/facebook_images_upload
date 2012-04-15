FacebookImagesUpload::Application.routes.draw do
  resources :events do
    resources :photos
  end

  resources :services do
    get 'import_status' => "services#import_status", :as => :import_status, :defaults => { :format => 'js' }
  end
  
  match "/auth/:provider/callback" => "services#create"
  match "/chat/:provider/:uid" => 'services#chat', :as => :chat
  match "/invite/:provider/:uid" => 'services#invite', :as => :invite
  match "/import/:provider" => "services#import", :as => :import
  
  mount Resque::Server, :at => "/resque"
end
