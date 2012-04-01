
require Rails.root.join('lib', 'host_meta_presenter')
require Rails.root.join('lib', 'webfinger_presenter')

class WebfingersController < ApplicationController

  layout false

  def host_meta
    @host_meta = HostMetaPresenter.new(request)
  end


  def webfinger_profile
    username = params[:q].split('@')[0].to_s.downcase

    user = User.find_by_username(username)
    @subject = WebfingerPresenter.new(user, request)
  end
end