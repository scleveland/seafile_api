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
	 self.token = self.get_token(self.host, self.username, self.password)
    end

	def get_token(host, username, password)
	  response = Curl::Easy.http_post(host+'/api2/auth-token/',Curl::PostField.content('username', username),Curl::PostField.content('password', password))do |c|
	    c.ssl_verify_peer = false 
	  end
	  JSON.parse(response.body)['token']
	end

	def account_info(host,token)
	  response = Curl::Easy.http_get(host+'/api2/account/info/') do |c|
	    c.ssl_verify_peer = false 
	    c.headers["Authorization"] = "Token #{token}"
	    c.headers["Accept"] = 'application/json; indent=4'
	  end
	  response.body
 	end

 	def starred_files(host,token)
 		seafile_get(host,"/api2/starredfiles/")
 	end

 	def default_repo(host,token)
 		result = seafile_get(host,"/api2/default-repo/")
 		result["repo_id"]
 	end

 	def list_libraries(host,token)
 		seafile_get(host,"/api2/repos/")
 	end

  private

    def seafile_get(host, path)
      response = Curl::Easy.http_get(host+path) do |c|
	    c.ssl_verify_peer = false 
	    c.headers["Authorization"] = "Token #{token}"
	    c.headers["Accept"] = 'application/json; indent=4'
	  end
	  JSON.parse(response.body) 
	end
end
