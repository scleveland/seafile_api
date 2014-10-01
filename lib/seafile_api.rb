#seafile_api.rb
require 'curb'
require 'json'

class Seafile

	attr_accessor :username
	attr_accessor :password
	attr_accessor :host
	attr_accessor :token

    def initialize(host,username,password,token=nil)
     self.username = username
	 self.password = password
	 self.host = host
	 if token.nil?
	   self.token = self.get_token()
	 else
	   self.token = token 
	 end
    end

	def get_token()
	  response = Curl::Easy.http_post(self.host+'/api2/auth-token/',Curl::PostField.content('username', self.username),Curl::PostField.content('password', self.password))do |c|
	    c.ssl_verify_peer = false 
	  end
	  JSON.parse(response.body)['token']
	end

	def account_info(host,token)
	  response = Curl::Easy.http_get(self.host+'/api2/account/info/') do |c|
	    c.ssl_verify_peer = false 
	    c.headers["Authorization"] = "Token #{self.token}"
	    c.headers["Accept"] = 'application/json; indent=4'
	  end
	  response.body
 	end

 	def starred_files()
 		seafile_get("/api2/starredfiles/")
 	end

 	def default_repo()
 		result = seafile_get("/api2/default-repo/")
 		result["repo_id"]
 	end

 	def list_libraries()
 		seafile_get("/api2/repos/")
 	end

 	def list_library_directory_entries(repo_id)
 		seafile_get("/api2/repos/#{repo_id}/dir/")
 	end

 	def list_directory_entries(repo_id, dir)
 		seafile_get("/api2/repos/#{repo_id}/dir/?p=#{dir}")
 	end


  private

    def seafile_get(path)
      response = Curl::Easy.http_get(self.host+path) do |c|
	    c.ssl_verify_peer = false 
	    c.headers["Authorization"] = "Token #{self.token}"
	    c.headers["Accept"] = 'application/json; indent=4'
	  end
	  JSON.parse(response.body) 
	end
end
