require 'net/https'
require 'json'
require 'uri'

id = 3727331
#id = 2917062

myreq = 'https://api.vkontakte.ru/method/getProfiles?uid=' + id.to_s + '&fields=online,domain,rate,bdate'

uri = URI.parse(myreq)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
ans = JSON.parse(response.body.slice(13..-3))
ans.each{|key,value| puts "#{key} = #{value}"}