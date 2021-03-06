require Rails.root.join('lib', 'exceptions')

class CoolStuffsController < ApplicationController
  before_filter :authenticate_request!

  layout :false

  rescue_from Exceptions::AuthenticationError do
    render :text => 'Cant Touch this', :code => 401, :status => 401
  end

  rescue_from Exceptions::ValidationError  do
    render :text => 'You are not a real person', :code => 401, :status => 401
  end
    
  def show
    if current_user.can_view?
      render :text => "the coolest story you have ever heard!"
    else
      raise Exceptions::AuthenticationError
    end
  end


  def authenticate_request!
    return true if current_user
    validator = WhoGrantSig::Validator.new(request.headers)
    #need to be able to tell it how to touch my local persons database, but I guess this could work for now
    raise Exceptions::ValidationError  unless validator.verified?

    @authenticated_requestor = RemoteRequester.new(validator.requestor) # remote requestor is a decorator/model around the webfinger profile
  end

  def current_user
    @authenticated_requestor
  end
end