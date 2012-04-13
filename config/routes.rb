FacebookImagesUpload::Application.routes.draw do
  resources :events do
    resources :photos
  end

  resources :services do
    get 'import_status' => "services#import_status", :as => :import_status, :defaults => { :format => 'js' }
  end
  
  match "/auth/:provider/callback" => "services#create"
  match "/import/:provider" => "services#import", :as => :import
  
  mount Resque::Server, :at => "/resque"
end
