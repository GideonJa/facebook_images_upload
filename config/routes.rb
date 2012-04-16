FacebookImagesUpload::Application.routes.draw do
  resources :events do
    resources :photos
  end

  resources :services do
    get 'import_status' => "services#import_status", :as => :import_status, :defaults => { :format => 'js' }
    get 'invite/:uid' => 'services#invite', :as => :invite
    post 'invite/:uid' => 'services#create_invitation', :as => :create_invitation
  end
  
  match "/auth/:provider/callback" => "services#create"
  match "/chat/:provider/:uid" => 'services#chat', :as => :chat
  match "/import/:provider" => "services#import", :as => :import
  
  mount Resque::Server, :at => "/resque"
end
