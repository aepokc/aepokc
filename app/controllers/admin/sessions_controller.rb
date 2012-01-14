class Admin::SessionsController < Devise::SessionsController
  prepend_before_filter :require_signed_out, :only => [:new]
end