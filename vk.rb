require 'sinatra'
require 'haml'
require 'net/https'
require 'json'
require 'uri'
require 'digest/md5'

use Rack::Auth::Basic do |username, password|
  Digest::MD5.hexdigest(username) == '21232f297a57a5a743894a0e4a801fc3' && Digest::MD5.hexdigest(password) == '404a4b240bff8fa46ed34f15a441d61e'
end

helpers do
  def mon
    myreq = 'https://api.vkontakte.ru/method/getProfiles?uid=' + @id.to_s + '&fields=online,domain,rate,bdate'

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
  @id = 3727331
  @ans = mon
  haml :index
end

get '/:id' do
  @id = params[:id]
  @ans = mon
  haml :index
end