module Checkpoints
  def create_checkpoint_submission(
                                    checkpoint_id: @checkpoint_id,
                                    enrollment_id: @current_enrollment_id,
                                    assignment_branch: "master",
                                    assignment_commit_link:"https://github.com/sanfordpaul/kele/commit/f79de0c8d970733ccd47f7cf4c8903fe26dfdd49",
                                    comment: 'This is a test submission from Paul Sanford working on kele client checkpoint. Do not approve.'
  )
  url ='https://www.bloc.io/api/v1/checkpoint_submissions'
  headers = {
    :content_type => 'application/json',
    :authorization => @auth_token
  }
  query = {
    "checkpoint_id": @checkpoint_id,
    "enrollment_id": @enrollment_id,
    "assignment_branch": assignment_branch,
    "assignment_commit_link": assignment_commit_link,
    "comment": comment
  }

  response = self.class.post( url, query:  query, headers: headers )
  end

end
