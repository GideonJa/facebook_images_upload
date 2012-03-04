FacebookImagesUpload::Application.routes.draw do
  resources :events do
    resources :photos
  end

  resources :services
  
  match "auth/:provider/callback" => "services#create"
end
