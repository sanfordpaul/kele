require 'httparty'
require 'json'
class Kele
  include HTTParty

  def initialize(email, password)
    @base_api_url = "https://www.bloc.io/api/v1"
    @options = { body: { email: email, password: password }  }
    response = self.class.post @base_api_url + '/sessions', @options
    @auth_token = response['auth_token']

    case response.code
      when 200
        puts "Response all good!"
      else
        raise " #{response.code} >> #{response}"
    end

     rescue Exception => exception
       puts exception.message
  end

  def get_me
    url = "https://www.bloc.io/api/v1/users/me"
    response = self.class.get(url, headers: { :content_type => 'application/json', :authorization => @auth_token })
    parsed_response_body = JSON.parse(response.body)
  end
end
