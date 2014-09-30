#seafile_api.rb
require 'curb'
require 'json'

class Seafile

	attr_accessor :username
	attr_accessor :password
	attr_accessor :host
	attr_accessor :token

    def initialize(host,username,password)
     self.username = username
	 self.password = password
	 self.host = host
	 self.token = self.get_token(sefl.host, selfusername, self.password)
    end

	def self.get_token(host, username, password)
	  response = Curl::Easy.http_post(base_url+'/api2/auth-token/',Curl::PostField.content('username', username),Curl::PostField.content('password', password))do |c|
	    c.ssl_verify_peer = false 
	  end
	  #if JSON.parse(response.body)
	  JSON.parse(response.body)['token']
	  #else
	 ## 	response.body
	  #end
	end

	
end
