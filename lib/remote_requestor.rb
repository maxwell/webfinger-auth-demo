class RemoteRequestor
  def initialize(webfinger_profile)
    @webfinger_profile = webfinger_profile
  end

  def can_access?
    true
  end
end