module Roadmap
  def get_roadmap(roadmap_id)
    url = "https://www.bloc.io/api/v1/roadmaps/#{roadmap_id}"
    response = self.class.get(url, headers: { :content_type => 'application/json', :authorization => @auth_token })
    parsed_response_body = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    url = "https://www.bloc.io/api/v1/checkpoints/#{checkpoint_id}"
    response = self.class.get(url, headers: { :content_type => 'application/json', :authorization => @auth_token })
    parsed_response_body = JSON.parse(response.body)
  end
end
