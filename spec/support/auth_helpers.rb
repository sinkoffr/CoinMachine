module AuthHelpers
  def authorization
    request.headers['TOKEN'] = ApiKey.last.access_token
  end
end