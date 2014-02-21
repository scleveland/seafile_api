#token.rb
require 'curb'
require 'json'

class Token
	def initialize(username, password, base_url)
    response = Curl::Easy.http_post("base_url",Curl::PostField.content('username', username),Curl::PostField.content('password', password))do |c|
	    c.ssl_verify_peer = false 
	  end
	  @@token = JSON.parse(respons.body_str).token
  end
end
 