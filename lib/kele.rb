require 'httparty'

class Kele
  include HTTParty
  def initialize(email, password)
    @base_api_url = "https://www.bloc.io/api/v1"
    @options = { body: { email: email, password: password }  }
    response = self.class.post @base_api_url + '/sessions', @options
    @api_key = response['auth_token']

    case response.code
      when 200
        puts "Response all good!"
      else
        raise " #{response.code} >> #{response}"
    end

     rescue Exception => exception
       puts exception.message


  end
end
