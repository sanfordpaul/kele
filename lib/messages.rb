module Messages

  def get_messages(page: 1)
    url = "https://www.bloc.io/api/v1/message_threads"
    headers = {
      :content_type => 'application/json',
      :authorization => @auth_token
    }
    query = { "page" => page }
    response = self.class.get(url, headers: headers, query: query   )
    parsed_response_body = JSON.parse(response.body)
  end

  def  create_message(
                      sender: @email,
                      user_id: @user_id,
                      thread_token: nil,
                      recipient_id: @mentor_id,
                      subject: "Kele Test Message from Paul Sanford",
                      stripped_text: "This is a test message sent by Paul Sanford for the kele messages checkpoint. No action needed. Feel free to delete after one hour"
                    )
    url = 'https://www.bloc.io/api/v1/messages'
    headers = {
      :content_type => 'application/json',
      :authorization => @auth_token
    }

     if thread_token
      query = {
        "sender": sender,
        "user_id": user_id,
        "recipient_id": recipient_id,
        "token": thread_token,
        "subject": subject,
        "stripped-text": stripped_text
      }
    else
      query = {
        "sender": sender,
        "user_id": user_id,
        "recipient_id": recipient_id,
        "subject": subject,
        "stripped-text": stripped_text
      }
    end
    response = self.class.post( url, query:  query, headers: headers )

  end

end
# thread_token for mark carpenter = '1c093a0a-b9df-432c-a686-17350cf3515e'
# my user id = 2379815
