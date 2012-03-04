FacebookImagesUpload::Application.routes.draw do
  resources :events do
    resources :photos
  end
  
  match "auth/:provider/callback" => "services#create"
end
