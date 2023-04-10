class ChatbotsController < ApplicationController
  #csrf tokenの問題で追記コード
  protect_from_forgery

  def create
    input = params[:input]
    client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
    # Define logic to generate response based on user input
    # https://platform.openai.com/docs/api-reference/chat/create
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Required.
        # role(役割)にはsystem, user, assistant三つある。
        # system: botを設定する時
        # user: UserのChat
        # assistant: BotのChat
        # 最初の{role: "system", content: "内容"}で返信するボットちゃんの設定をした。設定の内容はcontentに書く。
        messages: [
          { role: "system", content: "You are a helpful assistant. response to japanese" },
          { role: "user", content: input },
        ], # Required.
        temperature: 0.7,
        max_tokens: 200,
      },
    )

    # {
    #   "id": "chatcmpl-123",
    #   "object": "chat.completion",
    #   "created": 1677652288,
    #   "choices": [{ // 配列だからIndexで探す
    #     "index": 0,
    #     "message": {
    #       "role": "assistant",
    #       "content": "\n\nHello there, how may I assist you today?",
    #     },
    #     "finish_reason": "stop"
    #   }],
    #   "usage": {
    #     "prompt_tokens": 9,
    #     "completion_tokens": 12,
    #     "total_tokens": 21
    #   }
    # }
    respond_to do |format|
      format.json { render json: { response: response.dig("choices", 0, "message", "content") } }
    end
  end
end
