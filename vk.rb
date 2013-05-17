require 'sinatra'
require 'haml'
require 'net/https'
require 'json'
require 'uri'

helpers do
  def api_request_parser
    api_request = 'https://api.vk.com/method/users.get?uid=' + @id.to_s + '&fields=online,domain,rate,bdate,photo_big,last_seen'

    uri = URI.parse(api_request)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    json_answer = JSON.parse(response.body.slice(13..-3))
  end

  def pass_to_render
    @json_answer = api_request_parser
    @photo_big = @json_answer.delete("photo_big")
    @time_last_seen = @json_answer.delete("last_seen")
    haml :index
  end
end

get '/' do
  @id = 3727331
  pass_to_render
end

get '/:id' do
  @id = params[:id]
  pass_to_render
end
