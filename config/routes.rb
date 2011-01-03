Aepokc::Application.routes.draw do |map|

  namespace "members" do
  	match 'profiles/directory' => 'profiles#directory'
  	resources :profiles
  end
  
  match 'dues' => 'payments#dues'
  match 'dues/cancelled' => 'payments#cancelled'
  match 'dues/processed' => 'payments#processed'
  match 'db' => 'pages#db'
  match 'mail' => 'pages#mail'
	match 'admin' => 'pages#admin'
  devise_for :admin, :controllers => { :sessions => "admin/sessions" }
  devise_for :members, :controllers => { :registrations => "members/registrations", :sessions => "members/sessions" }
  
  match 'members/:id' => 'users#show', :as => 'member'
  match 'members' => 'users#index'
  resources :users, :as => 'members', :only => [:destroy]
  
  match 'membership/applications' => 'membership_applications#index'
  match 'membership/application' => 'membership_applications#new'
  
  resources :membership_applications, :except => [:index, :new]
  
	#  devise_scope :member do
	#  	resources :registrations, :module => "members", :only => [:index, :show], :as => :members
	#  end 
  
  match 'resources/calendar' => 'resources/calendar#show'
  
	namespace "resources" do
		resources :events
		resources :jobs
	end

  resources :payments
	resources :pages
  
  match ':parent/:link' => 'pages#show'
  match ':link' => 'pages#show'
	
  root :to => "pages#home"

end
