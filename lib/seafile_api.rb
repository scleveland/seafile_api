#seafile_api.rb
require 'curb'
require 'json'

class Seafile


	def self.token(base_url, username, password)
	  response = Curl::Easy.http_post(base_url+'/api2/auth-token/',Curl::PostField.content('username', username),Curl::PostField.content('password', password))do |c|
	    c.ssl_verify_peer = false 
	  end
	  if JSON.parse(response.body_str)
	    JSON.parse(response.body_str)['token']
	  else
	  	response.body_str
	  end
	end

	
end