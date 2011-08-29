require 'sinatra'
require 'haml'
require 'net/https'
require 'json'
require 'uri'

use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == 'vk182182'
end

helpers do
  def mon
    id = 3727331

    myreq = 'https://api.vkontakte.ru/method/getProfiles?uid=' + id.to_s + '&fields=online,domain,rate,bdate'

    uri = URI.parse(myreq)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    ans = JSON.parse(response.body.slice(13..-3)) 	 
    return ans
  end
end

get '/' do
  @ans = mon
  haml :index
end