require 'httparty'
require 'json'
if require_relative 'roadmap' then puts "roadmap required" end
if require_relative 'messages' then puts "messages required" end

class Kele
  include HTTParty
  include Roadmap
  include Messages

  def initialize(email, password)
    @email = email
    @base_api_url = "https://www.bloc.io/api/v1"
    @options = { body: { email: @email, password: password }  }
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

  def get_mentor_availability(mentor_id)
    url = "https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability"
    response = self.class.get(url, headers: { :content_type => 'application/json', :authorization => @auth_token })
    parsed_response_body = JSON.parse(response.body)
  end


end
