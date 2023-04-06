class ChatbotsController < ApplicationController
  protect_from_forgery

  def create
    input = params[:input]
    client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
    # Define logic to generate response based on user input
    # https://platform.openai.com/docs/api-reference/chat/create
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "system", content: "You are a helpful assistant. response english to japanese" }, { role: "user", content: input }], # Required.
        temperature: 0.7,
        max_tokens: 200,
      },
    )

    respond_to do |format|
      format.json { render json: { response: response.dig("choices", 0, "message", "content") } }
    end
  end
end
