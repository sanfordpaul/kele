require 'httparty'
require 'json'
 load './lib/roadmap.rb'
 load './lib/messages.rb'
 load './lib/checkpoints.rb'
class Kele
  include HTTParty
  include Roadmap, Messages, Checkpoints


  def initialize(email, password)
    @email = email
    @base_api_url = "https://www.bloc.io/api/v1"
    options = { body: { email: @email, password: password }  }
    response = self.class.post @base_api_url + '/sessions', options
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

  def self.do_all
    kele_client = Kele.new("sanfordpaul@gmail.com", "08r0F3IFFuFk")
    kele_client.get_me
    kele_client.get_roadmap
    kele_client.create_checkpoint_submission
  end

  def get_me
    url = "https://www.bloc.io/api/v1/users/me"
    response = self.class.get(url, headers: { :content_type => 'application/json', :authorization => @auth_token })
    parsed_response_body = JSON.parse(response.body)
    @user_id = parsed_response_body["id"]
    @mentor_id = parsed_response_body["current_enrollment"]["mentor_id"]
    @roadmap_id = parsed_response_body["current_enrollment"]["roadmap_id"]
    @current_enrollment_id = parsed_response_body["current_enrollment"]["id"]
    parsed_response_body
  end

  def get_mentor_availability(mentor_id: @mentor_id)
    url = "https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability"
    response = self.class.get(url, headers: { :content_type => 'application/json', :authorization => @auth_token })
    parsed_response_body = JSON.parse(response.body)
  end


end
