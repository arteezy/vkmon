require 'sinatra'
require 'haml'
require 'net/https'
require 'json'
require 'uri'

helpers do
  def api_request_parser(id)
    fields = %w(online education city domain rate bdate photo_big last_seen)
    api_request = "https://api.vk.com/method/users.get?user_ids=#{id.to_s}&v=5.27&fields=#{fields.join(',')}"

    uri = URI.parse(api_request)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    json_answer = JSON.parse(response.body)["response"].first
  end

  def pass_to_render(id)
    @json_answer = api_request_parser(id)
    haml :index
  end
end

get '/' do
  id = 3727331
  pass_to_render(id)
end

get '/:id' do
  pass_to_render(params[:id])
end
