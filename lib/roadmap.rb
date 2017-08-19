module Roadmap
  def get_roadmap(roadmap_id: @roadmap_id)
    url = "https://www.bloc.io/api/v1/roadmaps/#{roadmap_id}"
    response = self.class.get(url, headers: { :content_type => 'application/json', :authorization => @auth_token })
    parsed_response_body = JSON.parse(response.body)
    section = parsed_response_body["sections"].find {|section| section['id'] == 332 }
    checkpoint = section["checkpoints"].find {|checkpoint| checkpoint['id'] == 2555 }
    @checkpoint_id = checkpoint["id"]
    parsed_response_body
  end

  def get_checkpoint(checkpoint_id: @checkpoint_id)
    url = "https://www.bloc.io/api/v1/checkpoints/#{checkpoint_id}"
    response = self.class.get(url, headers: { :content_type => 'application/json', :authorization => @auth_token })
    parsed_response_body = JSON.parse(response.body)
  end
end

# current section "id"=>332
# current checkpoint "id"=>2555
