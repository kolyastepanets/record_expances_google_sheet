class ReceiveMonzoFromApiAccessToken
  include CallableService

  EXPIRES_IN = 28.hours # token expires in 29 hours

  def initialize
    @redis = Redis.new
  end

  def call
    token = check_current_access_token
    return token if token

    get_new_access_token
  end

  private

  def check_current_access_token
    response = Faraday.new(
      url: "https://api.monzo.com/ping/whoami",
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{@redis.get('monzo_access_token')}"
      }
    ).get

    res = JSON.parse(response.body)
    return @redis.get('monzo_access_token') if res["authenticated"]

    nil
  end

  def get_new_access_token
    uri = URI("https://api.monzo.com/oauth2/token")
    request = Net::HTTP::Post.new(uri)
    request.content_type = 'application/x-www-form-urlencoded'
    request.set_form_data(
      'grant_type' => 'refresh_token',
      'client_id' => ENV['MONZO_CLIENT_ID'],
      'client_secret' => ENV['MONZO_CLIENT_SECRET'],
      'redirect_uri' => ENV['CURRENT_URL'],
      'refresh_token' => @redis.get('monzo_refresh_token')
    )
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    access_token  = JSON.parse(response.body)["access_token"]
    refresh_token = JSON.parse(response.body)["refresh_token"]
    @redis.set('monzo_access_token', access_token, ex: EXPIRES_IN)
    @redis.set('monzo_refresh_token', refresh_token)
    access_token
  end
end
