Aepokc::Application.routes.draw do |map|
  resources :emails
  get 'holiday' => 'pages#holiday'
  get 'membership/profiles/directory' => 'profiles#directory'

  namespace "members" do
    match 'profiles/directory' => 'profiles#directory'
    resources :profiles
  end
  
  get 'dues' => 'payments#dues'
  get 'dues/mail' => 'payments#mail'
  get 'dues/cancelled' => 'payments#cancelled'
  get 'dues/processed' => 'payments#processed'
  get 'db' => 'pages#db'
  get 'mail' => 'pages#mail'
  get 'admin' => 'pages#admin'
  devise_for :admin, :controllers => { :sessions => "admin/sessions" }
  devise_for :members, :controllers => { :registrations => "members/registrations", :sessions => "members/sessions", :confirmations => "members/confirmations" }
  
  get 'members/:id' => 'users#show', :as => 'member'
  get 'members' => 'users#index'
  delete 'member/:id' => 'users#destroy', :as => 'destroy_member'
  
  get 'approve' => 'membership_applications#approve'
  get 'membership/applications' => 'membership_applications#index'
  get 'membership/application' => 'membership_applications#new'
  post 'membership/applications' => 'membership_applications#create'
  get 'membership/applications/:id' => 'membership_applications#show', :as => 'applicant'
  
  resources :membership_applications, :except => [:index, :new, :create, :show]
  
  #  devise_scope :member do
  #   resources :registrations, :module => "members", :only => [:index, :show], :as => :members
  #  end 
  
  get 'resources/calendar' => 'resources/calendar#show'
  
  get 'emails/jobs/:id' => 'resources/jobs#email', :as => 'job_email'
  
  namespace "resources" do
    resources :events
    resources :jobs
  end

  resources :payments
  resources :pages
  
  get ':parent/:link' => 'pages#show'
  get ':link' => 'pages#show'
  
  root :to => "pages#home"
end